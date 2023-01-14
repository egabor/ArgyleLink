//
//  StartSearchUseCase.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 14..
//

import Foundation

protocol StartSearchUseCaseProtocol {

    /// This function decides if the search needs to be performed or not.
    ///
    /// - Parameters:
    ///     - minimumInputCharacters: The number of characters when the search can be performed.
    ///     - searchText: The lookup value.
    ///     - mostRecentSearchText: The most recent valid lookup value from the previous search.
    ///
    /// - Returns: The value if the search needs to be performed or not.
    func callAsFunction(
        _ minimumInputCharacters: Int,
        _ searchText: String,
        _ mostRecentSearchText: String
    ) -> Bool
}

class StartSearchUseCase: StartSearchUseCaseProtocol {

    func callAsFunction(
        _ minimumInputCharacters: Int,
        _ searchText: String,
        _ mostRecentSearchText: String
    ) -> Bool {
        isAllowedToPerformSearch(minimumInputCharacters, searchText) &&
        isSearchNeededToPerform(searchText, mostRecentSearchText)
    }

    private func isAllowedToPerformSearch(
        _ minimumInputCharacters: Int,
        _ searchText: String
    ) -> Bool {
        minimumInputCharacters <= searchText.count
    }

    private func isSearchNeededToPerform(
        _ searchText: String,
        _ mostRecentSearchText: String
    ) -> Bool {
        searchText != mostRecentSearchText && searchText.isEmpty == false
    }
}
