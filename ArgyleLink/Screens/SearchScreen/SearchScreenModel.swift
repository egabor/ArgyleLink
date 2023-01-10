//
//  SearchScreenModel.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Combine

typealias SearchScreenModelProtocol = SearchViewModelProtocol

class SearchScreenModel: SearchScreenModelProtocol {

    @Published var searchText: String = ""
    private (set) var isSearchFieldDisabled: Bool = false
    private (set) var isSearchDisabled: Bool = false

    init() {}

    func search() {  }
    func loadNextPage() {  }
    func clearSearch() {  }
}
