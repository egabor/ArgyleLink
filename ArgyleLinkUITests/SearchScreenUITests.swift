//
//  SearchScreenUITests.swift
//  ArgyleLinkUITests
//
//  Created by Eszenyi Gábor on 2023. 01. 15..
//

import XCTest
@testable import ArgyleLink

final class SearchScreenUITests: XCTestCase {

    let defaultTimeout: Double = 10

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchScreen_initialState() throws {
        launchApplication()

        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let searchInput = XCUIApplication().textFields["searchView"]
        let clearButton = XCUIApplication().buttons["searchViewClearButton"]
        let emptyStateView = XCUIApplication().staticTexts["companyListInitialEmptyState"]

        iShouldSee(searchInput, timeout: defaultTimeout)
        iShouldNotSee(clearButton)
        iShouldSee(emptyStateView, timeout: defaultTimeout)
    }

    func testSearchScreen_userEntersInput() throws {
        launchApplication()

        let searchInput = XCUIApplication().textFields["searchView"]
        let clearButton = XCUIApplication().buttons["searchViewClearButton"]
        let noResultsStateView = XCUIApplication().staticTexts["companyListNoResultsEmptyState"]

        iShouldSee(searchInput, timeout: defaultTimeout)
        typeText(into: searchInput, text: "thhfeghj")
        iShouldSee(clearButton)
        iShouldSee(noResultsStateView, timeout: 10)
    }
}

extension XCTestCase {

    func launchApplication() {
        let app = XCUIApplication()
        app.launch()
    }

    func iShouldSee(_ element: XCUIElement, timeout: Double? = nil) {
        XCTContext.runActivity(named: "I should see \(element)") { _ in
            if let timeout {
                XCTAssert(element.waitForExistence(timeout: timeout))
            } else {
                XCTAssert(element.exists)
            }
        }
    }

    func iShouldNotSee(_ element: XCUIElement) {
        XCTContext.runActivity(named: "I should NOT see \(element)") { _ in
            XCTAssertFalse(element.exists)
        }
    }

    func typeText(into element: XCUIElement, text: String) {
        XCTContext.runActivity(named: "When I tap on \(element)") { _ in
            XCTAssert(element.exists)
            element.tap()
            element.typeText(text)
        }
    }
}
