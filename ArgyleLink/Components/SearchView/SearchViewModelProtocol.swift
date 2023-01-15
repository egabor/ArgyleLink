//
//  SearchViewModelProtocol.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

protocol SearchViewModelProtocol: ObservableObject {

    var searchText: String { get set }
    var mostRecentSearchText: String { get set }
}

extension SearchViewModelProtocol {

    var showsClearButton: Bool {
        !searchText.isEmpty
    }

    func clearSearch() {
        searchText = ""
        mostRecentSearchText = ""
    }
}

// MARK: - Localized

extension SearchViewModelProtocol {

    var searchFieldPlaceholder: String {
        .searchScreenSearchTextFieldPlaceholder
    }
}

// MARK: - Accessibility Identifiers

extension SearchViewModelProtocol {

    var searchViewAccessibilityIdentifier: String {
        .accessibilityIdSearchView
    }

    var clearButtonAccessibilityIdentifier: String {
        .accessibilityIdSearchViewClearButton
    }
}
