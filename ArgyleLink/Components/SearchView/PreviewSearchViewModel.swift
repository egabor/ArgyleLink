//
//  PreviewSearchViewModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

class PreviewSearchViewModel: SearchViewModelProtocol {

    var searchText: String = ""
    private (set) var isSearchFieldDisabled: Bool = false
    private (set) var isSearchDisabled: Bool = false

    init() {}

    func search() { /* No action needs to be performed here. */ }
    func loadNextPage() { /* No action needs to be performed here. */ }
    func clearSearch() { /* No action needs to be performed here. */ }
}
