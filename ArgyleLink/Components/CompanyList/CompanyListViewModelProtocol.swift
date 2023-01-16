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
    var trimmedSearchText: String { get set }
    var mostRecentSearchText: String { get set }
    var isLoading: Bool { get set }
    var isEmpty: Bool { get }
    var minimumInputCharacters: Int { get }
    var errorMessage: String { get set }
}

extension CompanyListViewModelProtocol {

    var hasNoResultsForKeyword: Bool {
        mostRecentSearchText.isEmpty == false &&
        mostRecentSearchText == trimmedSearchText
    }

    var emptyListText: String {
        if hasNoResultsForKeyword {
            if errorMessage.isEmpty {
                return localizedString(
                    .searchScreenCompanyListNoResultsStateTitle,
                    with: mostRecentSearchText
                )
            } else {
                return errorMessage
            }
        } else {
            if trimmedSearchText.isEmpty {
                return localizedString(
                    .searchScreenCompanyListInitialStateTitle,
                    with: minimumInputCharacters
                )
            } else {
                return localizedString(
                    .searchScreenCompanyListInitialStateTypeMoreTitle,
                    with: max(0, minimumInputCharacters - trimmedSearchText.count)
                )
            }
        }
    }

    fileprivate func localizedString(_ string: String, with param: CVarArg) -> String {
        String(format: NSLocalizedString(string, comment: ""), param)
    }
}

// MARK: - Accessibility Identifiers

extension CompanyListViewModelProtocol {

    var initialEmptyStateAccessibilityId: String {
        .accessibilityIdCompanyListInitialEmptyState
    }

    var noResultsEmptyStateAccessibilityId: String {
        .accessibilityIdCompanyListNoResultsEmptyState
    }

    var placeholderCompanyListAccessibilityId: String {
        .accessibilityIdPlaceholderCompanyList
    }

    var companyListAccessibilityId: String {
        .accessibilityIdCompanyList
    }
}
