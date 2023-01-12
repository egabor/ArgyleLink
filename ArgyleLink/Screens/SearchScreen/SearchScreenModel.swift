//
//  SearchScreenModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Combine
import Resolver

typealias SearchScreenModelProtocol = SearchViewModelProtocol &
CompanyListViewModelProtocol & LoadingCapable

class SearchScreenModel: SearchScreenModelProtocol {

    // MARK: - Constants

    let minimumInputCharacters = 2
    let debounceTimeIntervalInMilliseconds = 500

    // MARK: - SearchViewModelProtocol

    @Published var searchText: String = ""
    private (set) var isSearchFieldDisabled: Bool = false

    // MARK: - CompanyListViewModelProtocol

    @Published var companies: [CompanyListItemViewModel] = []
    @Published internal var mostRecentSearchText: String = ""
    var isEmpty: Bool {
        companies.isEmpty
    }

    // MARK: - LoadingCapable

    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?

    @Injected private var getCompanies: GetCompaniesUseCaseProtocol

    init() {
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

        // This publisher is responsible for resetting the screen immediately when the user clears the search field.

        $searchText
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                self?.searchCancellable?.cancel()
                self?.companies = []
                self?.mostRecentSearchText = ""
            }
            .store(in: &cancellables)
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
        searchCancellable = getCompanies(for: searchText)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("error: \(error)")
                }
            } receiveValue: { [weak self] results in
                self?.companies = results
                self?.mostRecentSearchText = searchText
            }
    }
}
