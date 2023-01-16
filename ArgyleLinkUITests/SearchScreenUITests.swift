//
//  SearchScreenUITests.swift
//  ArgyleLinkUITests
//
//  Created by Eszenyi Gábor on 2023. 01. 15..
//

import XCTest

enum SearchScreenUIElements: String {
    case searchView = "searchView"
    case clearButton = "searchViewClearButton"
    case initialEmptyStateView = "companyListInitialEmptyState"
    case noResultsEmptyStateView = "companyListNoResultsEmptyState"
    case placeholderCompanyList = "placeholderCompanyList"
    case companyList = "companyList"

    var element: XCUIElement {
        switch self {
        case .searchView:
            return XCUIApplication().textFields[rawValue]
        case .clearButton:
            return XCUIApplication().buttons[rawValue]
        case .initialEmptyStateView, .noResultsEmptyStateView:
            return XCUIApplication().staticTexts[rawValue]
        case .companyList, .placeholderCompanyList:
            return XCUIApplication().scrollViews[rawValue]
        }
    }
}

final class SearchScreenUITests: XCTestCase {

    let defaultTimeout: Double = 10

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchScreen_initialState() throws {
        launchApplication()

        let screen = SearchScreenUIElements.self

        iShouldSee(screen.searchView.element, timeout: defaultTimeout)
        iShouldNotSee(screen.clearButton.element)
        iShouldSee(screen.initialEmptyStateView.element)
    }

    func testSearchScreen_userEntersInput_shouldSeeNoResults() throws {
        launchApplication()

        let screen = SearchScreenUIElements.self

        iShouldSee(screen.searchView.element, timeout: defaultTimeout)
        typeText(into: screen.searchView.element, text: "thhfeghj")
        iShouldSee(screen.clearButton.element)
        iShouldSee(screen.noResultsEmptyStateView.element, timeout: defaultTimeout)
    }

    func testSearchScreen_userEntersInput_thenClearsInput_shouldSeeInitialState() throws {
        launchApplication()

        let screen = SearchScreenUIElements.self

        iShouldSee(screen.searchView.element, timeout: defaultTimeout)
        typeText(into: screen.searchView.element, text: "thhfeghj")
        iShouldSee(screen.clearButton.element)
        iShouldSee(screen.noResultsEmptyStateView.element, timeout: defaultTimeout)

        screen.clearButton.element.tap()

        iShouldNotSee(screen.clearButton.element)
        iShouldSee(screen.initialEmptyStateView.element)
    }

    func testSearchScreen_userEntersValidInput_shouldSeeResults() throws {
        launchApplication()

        let screen = SearchScreenUIElements.self

        iShouldSee(screen.searchView.element, timeout: defaultTimeout)
        typeText(into: screen.searchView.element, text: "am")
        iShouldSee(screen.placeholderCompanyList.element)
        iShouldSee(screen.companyList.element, timeout: defaultTimeout)
    }
}
