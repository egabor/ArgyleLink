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
        .searchScreenSearchTextFieldPlaceholder
    }
}
