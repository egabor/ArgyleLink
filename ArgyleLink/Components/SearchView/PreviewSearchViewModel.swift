//
//  PreviewSearchViewModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

class PreviewSearchViewModel: SearchViewModelProtocol {

    var searchText: String = ""
    var mostRecentSearchText: String = ""
    private (set) var isSearchFieldDisabled: Bool = false

    init() {}
}
