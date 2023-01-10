//
//  CompanyListViewModelProtocol.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import Combine

protocol CompanyListViewModelProtocol: ObservableObject {

    var companies: [CompanyViewData] { get set }
    var mostRecentSearchText: String { get set }
    var isEmpty: Bool { get }
}

extension CompanyListViewModelProtocol {

    var emptyListText: String {
        guard mostRecentSearchText.isEmpty else {
            return String(
                format: NSLocalizedString(
                    .searchScreenCompanyListNoResultsStateTitle,
                    comment: ""
                ),
                mostRecentSearchText
            )
        }
        return .searchScreenCompanyListInitialStateTitle
    }
}
