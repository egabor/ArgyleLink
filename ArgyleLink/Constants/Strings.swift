//
//  Strings.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation

// swiftlint:disable identifier_name

// MARK: - Localization

extension String {
    static let searchScreenSearchTextFieldPlaceholder = "searchScreen.search.textField.placeholder"
    static let searchScreenCompanyListInitialStateTitle = "searchScreen.companyList.initialState.title"
    static let searchScreenCompanyListInitialStateTypeMoreTitle = "searchScreen.companyList.initialStateTypeMore.title"
    static let searchScreenCompanyListNoResultsStateTitle = "searchScreen.companyList.noResultsState.title"

    static let alertErrorTitle = "alert.error.title"
    static let alertOkButtonTitle = "alert.ok.button.title"
}

// MARK: - Accessibility Identifiers

extension String {
    static let accessibilityIdSearchView = "searchView"
    static let accessibilityIdSearchViewClearButton = "searchViewClearButton"

    static let accessibilityIdCompanyListInitialEmptyState = "companyListInitialEmptyState"
    static let accessibilityIdCompanyListNoResultsEmptyState = "companyListNoResultsEmptyState"
    static let accessibilityIdPlaceholderCompanyList = "placeholderCompanyList"
    static let accessibilityIdCompanyList = "companyList"
}

// swiftlint:enable identifier_name
