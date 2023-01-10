//
//  SearchViewModelProtocol.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

protocol SearchViewModelProtocol: ObservableObject {

    var searchText: String { get set }
    var isSearchFieldDisabled: Bool { get }
    var isSearchDisabled: Bool { get }

    func search()
    func loadNextPage()
    func clearSearch()
}

extension SearchViewModelProtocol {

    var showsClearButton: Bool {
        !searchText.isEmpty
    }

    func clearSearch() {
        searchText = ""
    }
}

extension SearchViewModelProtocol {

    var searchFieldPlaceholder: String {
        String.searchScreenSearchTextFieldPlaceholder
    }

    var searchButtonTitle: String {
        String.searchScreenSearchButtonTitle
    }
}
