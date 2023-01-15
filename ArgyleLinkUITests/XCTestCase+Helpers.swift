//
//  XCTestCase+Helpers.swift
//  ArgyleLinkUITests
//
//  Created by Eszenyi Gábor on 2023. 01. 15..
//

import XCTest

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
