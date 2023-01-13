//
//  BasicAuthorizationValueUseCaseTests.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 13..
//

import XCTest
@testable import ArgyleLink

final class BasicAuthorizationValueUseCaseTests: XCTestCase {

    let authorizationValue: BasicAuthorizationValueUseCase = .init()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_authorizationValue_whenAllInputIsValid_shouldReturnSuccess() throws {
        let expectedOutput = "Basic dXNlcjpwYXNz"
        let output = authorizationValue(username: "user", password: "pass")
        XCTAssertEqual(expectedOutput, output)
    }
}
