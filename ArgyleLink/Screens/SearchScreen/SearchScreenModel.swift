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

    // MARK: - SearchViewModelProtocol

    @Published var searchText: String = ""

    // MARK: - CompanyListViewModelProtocol

    @Published var companies: [CompanyListItemViewModel] = []
    @Published internal var mostRecentSearchText: String = ""
    var isEmpty: Bool {
        companies.isEmpty
    }
    var minimumInputCharacters: Int {
        2
    }

    // MARK: - LoadingCapable

    @Published var isLoading: Bool = false

    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    private var cancellables = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?

    @Injected private var logger: Logger
    @Injected private var getCompanies: GetCompaniesUseCaseProtocol

    init() {
        logger.info("\(Self.self) initialized.")
        setupPublishers()
    }

    private func setupPublishers() {

        Publishers.CombineLatest($searchText, $mostRecentSearchText)
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

        Publishers.CombineLatest($searchText, $mostRecentSearchText)
            .map { [weak self] (searchText, mostRecentSearchText) in
                self?.shouldStartSearch(searchText, mostRecentSearchText) ?? false
            }
            .assign(to: &$isLoading)

        // This publisher is responsible for resetting the screen.

        $searchText
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

    func isAllowedToPerformSearch(_ searchText: String) -> Bool {
        minimumInputCharacters <= searchText.count
    }

    func isSearchNeededToPerform(_ searchText: String, _ mostRecentSearchText: String) -> Bool {
        searchText != mostRecentSearchText && searchText.isEmpty == false
    }

    func shouldStartSearch(_ searchText: String, _ mostRecentSearchText: String) -> Bool {
        isAllowedToPerformSearch(searchText) && isSearchNeededToPerform(searchText, mostRecentSearchText)
    }

    func searchParameters(_ searchText: String, _ mostRecentSearchText: String) -> (Bool, String) {
        let shouldStartSearch = shouldStartSearch(searchText, mostRecentSearchText)
        return (shouldStartSearch, searchText)
    }

    func performSearch(_ searchText: String) {
        logger.info("Starting search with expression: \(searchText)")
        searchCancellable = getCompanies(for: searchText)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.logger.error("Error occurred during the search: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
                self?.mostRecentSearchText = searchText
            } receiveValue: { [weak self] results in
                self?.logger.info("Received search results. Count: \(results.count)")
                self?.companies = results
            }
    }
}
