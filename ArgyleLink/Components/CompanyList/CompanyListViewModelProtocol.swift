//
//  CompanyListViewModelProtocol.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Combine

protocol CompanyListViewModelProtocol: ObservableObject {

    var companies: [CompanyListItemViewModel] { get set }
    var searchText: String { get set }
    var mostRecentSearchText: String { get set }
    var isLoading: Bool { get set }
    var isEmpty: Bool { get }
    var minimumInputCharacters: Int { get }
}

extension CompanyListViewModelProtocol {

    var hasNoResultsForKeyword: Bool {
        mostRecentSearchText.isEmpty == false &&
        mostRecentSearchText == searchText &&
        companies.isEmpty
    }

    var emptyListText: String {
        if mostRecentSearchText.isEmpty == false && mostRecentSearchText == searchText {
            return localizedString(
                .searchScreenCompanyListNoResultsStateTitle,
                with: mostRecentSearchText
            )
        } else {
            if searchText.isEmpty {
                return localizedString(
                    .searchScreenCompanyListInitialStateTitle,
                    with: minimumInputCharacters
                )
            } else {
                return localizedString(
                    .searchScreenCompanyListInitialStateTypeMoreTitle,
                    with: max(0, minimumInputCharacters - searchText.count)
                )
            }
        }
    }

    func localizedString(_ string: String, with param: CVarArg) -> String {
        String(format: NSLocalizedString(string, comment: ""), param)
    }
}
