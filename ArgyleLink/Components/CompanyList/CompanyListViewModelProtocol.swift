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
}

extension CompanyListViewModelProtocol {

    var hasNoResultsForKeyword: Bool {
        mostRecentSearchText.isEmpty == false &&
        mostRecentSearchText == searchText &&
        companies.isEmpty
    }

    var emptyListText: String {
        if mostRecentSearchText.isEmpty == false && mostRecentSearchText == searchText {
            return String(
                format: NSLocalizedString(
                    .searchScreenCompanyListNoResultsStateTitle,
                    comment: ""
                ),
                mostRecentSearchText
            )
        } else {
            return .searchScreenCompanyListInitialStateTitle
        }
    }


}
