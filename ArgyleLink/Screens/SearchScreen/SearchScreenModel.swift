//
//  SearchScreenModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Combine
import Resolver
import Logging

typealias SearchScreenModelProtocol = SearchViewModelProtocol &
CompanyListViewModelProtocol & LoadingCapable & ErrorCapable

class SearchScreenModel: SearchScreenModelProtocol {

    // MARK: - Constants

    let debounceTimeIntervalInMilliseconds = 500

    // MARK: - Input Variables

    @Published var searchText: String = ""

    // MARK: - Output Variables

    @Published var companies: [CompanyListItemViewModel] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var isEmpty: Bool {
        companies.isEmpty
    }

    // MARK: - Internal Properties

    var minimumInputCharacters: Int {
        Configuration.minimumInputCharacters
    }

    @Published var trimmedSearchText: String = ""
    @Published var mostRecentSearchText: String = ""

    private var cancellables = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?

    @Injected private var logger: Logger
    @Injected private var getCompanies: GetCompaniesUseCaseProtocol
    @Injected private var shouldStartSearch: StartSearchUseCaseProtocol

    init() {
        logger.info("\(Self.self) initialized.")
        setupPublishers()
    }

    private func setupPublishers() {

        $searchText
            .map { $0.trimmed }
            .removeDuplicates()
            .assign(to: &$trimmedSearchText)

        let combinedSearchTextWithMostRecent = Publishers.CombineLatest(
            $trimmedSearchText,
            $mostRecentSearchText
        )

        combinedSearchTextWithMostRecent
            .compactMap { [weak self] searchText, mostRecentSearchText -> (Bool, String)? in
                self?.searchParameters(searchText, mostRecentSearchText)
            }
            .debounce(
                for: .milliseconds(debounceTimeIntervalInMilliseconds),
                scheduler: DispatchQueue.main
            )
            .filter { (shouldStartSearch, _) in shouldStartSearch }
            .map { $1 }
            .sink(
                receiveValue: { [weak self] text in
                    guard let self else { return }
                    self.performSearch(text)
                }
            )
            .store(in: &cancellables)

        // This publisher is responsible to decide whether to show the loading or not.

        combinedSearchTextWithMostRecent
            .map { [weak self] searchText, mostRecentSearchText in
                guard let self = self else { return false }
                return self.shouldStartSearch(
                    self.minimumInputCharacters,
                    searchText,
                    mostRecentSearchText
                )
            }
            .assign(to: &$isLoading)

        // This publisher is responsible for resetting the screen.

        $trimmedSearchText
            .map { $0.trimmed }
            .filter { [weak self] searchText in
                searchText.count < self?.minimumInputCharacters ?? 1
            }
            .sink { [weak self] _ in
                self?.searchCancellable?.cancel()
                self?.companies = []
                self?.mostRecentSearchText = ""
            }
            .store(in: &cancellables)

        // This publisher is responsible for showing an error if needed.

        $errorMessage
            .map { $0.isEmpty == false }
            .assign(to: &$showError)
    }

    private func searchParameters(_ searchText: String, _ mostRecentSearchText: String) -> (Bool, String) {
        let shouldStartSearch = shouldStartSearch(
            minimumInputCharacters,
            searchText,
            mostRecentSearchText
        )
        return (shouldStartSearch, searchText)
    }

    private func performSearch(_ searchText: String) {
        logger.info("Starting search with expression: \(searchText)")
        searchCancellable = getCompanies(for: searchText)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.logger.error("Error occurred during the search: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.errorMessage = ""
                }
                self?.mostRecentSearchText = searchText
            } receiveValue: { [weak self] results in
                self?.logger.info("Received search results. Count: \(results.count)")
                self?.companies = results
            }
    }
}
