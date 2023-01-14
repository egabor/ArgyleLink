//
//  StartSearchUseCaseTests.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 14..
//

import XCTest
@testable import ArgyleLink

// swiftlint:disable line_length
final class StartSearchUseCaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_noMinimumInputLimit_andSearchTextIsNotEqualToMostRecentSearchText_shouldReturnTrue() throws {
        let shouldStartSearch = StartSearchUseCase()
        XCTAssertTrue(shouldStartSearch(0, "test", ""))
    }

    func test_theresMinimumInputLimit_andSearchTextIsNotEqualToMostRecentSearchText_andSearchTextLengthIsAboveLimit_shouldReturnTrue() throws {
        let shouldStartSearch = StartSearchUseCase()
        XCTAssertTrue(shouldStartSearch(2, "test", ""))
    }

    func test_theresMinimumInputLimit_andSearchTextLengthIsBelowLimit_shouldReturnFalse() throws {
        let shouldStartSearch = StartSearchUseCase()
        XCTAssertFalse(shouldStartSearch(2, "t", ""))
    }

    func test_theresMinimumInputLimit_andSearchTextIsEqualToMostRecentSearchText_andSearchTextLengthIsAboveLimit_shouldReturnFalse() throws {
        let shouldStartSearch = StartSearchUseCase()
        XCTAssertFalse(shouldStartSearch(2, "test", "test"))
    }
}
// swiftlint:enable line_length
