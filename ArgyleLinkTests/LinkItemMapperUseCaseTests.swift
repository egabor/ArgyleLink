//
//  LinkItemMapperUseCaseTests.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 13..
//

import XCTest
@testable import ArgyleLink

// swiftlint:disable line_length
final class LinkItemMapperUseCaseTests: XCTestCase {

    let mapLinkItem: LinkItemMapperUseCase = .init()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_linkItemMapper_whenLogoUrlIsNil_shouldReturn_companyListItemViewModel() throws {
        let input = LinkItemResponse(id: "testId", name: "testName", kind: .creator, logoUrl: nil)
        let output = CompanyListItemViewModel(id: "testId", name: "testName", kind: "creator", logoUrl: nil)

        XCTAssertEqual(mapLinkItem(input), output)
    }

    func test_linkItemMapper_shouldReturn_companyListItemViewModel() throws {
        let input = LinkItemResponse(id: "testId", name: "testName", kind: .creator, logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1598543068/partner-logos/amazon.png")
        let output = CompanyListItemViewModel(id: "testId", name: "testName", kind: "creator", logoUrl: "https://res.cloudinary.com/argyle-media/image/upload/v1598543068/partner-logos/amazon.png")

        XCTAssertEqual(mapLinkItem(input), output)
    }
}
// swiftlint:enable line_length
