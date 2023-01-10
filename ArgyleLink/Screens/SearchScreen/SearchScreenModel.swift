//
//  SearchScreenModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

typealias SearchScreenModelProtocol = SearchViewModelProtocol &
CompanyListViewModelProtocol & LoadingCapable

class SearchScreenModel: SearchScreenModelProtocol {

    // MARK: - SearchViewModelProtocol

    @Published var searchText: String = ""
    private (set) var isSearchFieldDisabled: Bool = false

    // MARK: - CompanyListViewModelProtocol

    @Published var companies: [CompanyViewData] = .previewArray
    internal var mostRecentSearchText: String = ""
    var isEmpty: Bool {
        companies.isEmpty
    }

    // MARK: - LoadingCapable

    @Published var isLoading: Bool = false

    init() {}
}
