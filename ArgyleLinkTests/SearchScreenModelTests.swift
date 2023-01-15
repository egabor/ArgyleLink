//
//  SearchScreenModelTests.swift
//  ArgyleLinkTests
//
//  Created by Eszenyi Gábor on 2023. 01. 13..
//

import XCTest
import Resolver
import Combine
@testable import ArgyleLink

final class SearchScreenModelTests: XCTestCase {

    private var subscriptions: Set<AnyCancellable>!
    @LazyInjected private var searchApi: MockSearchApi

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        subscriptions = []
        Resolver.resetUnitTestRegistrations()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewModelState_initial() throws {
        let viewModel = SearchScreenModel()

        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)
    }

    func test_viewModelState_whenSearchTextLengthBelowLimit_shouldReturnInitialState() throws {
        let viewModel = SearchScreenModel()
        let searchText = "t"
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)
    }

    func test_viewModelState_whenSearchTextLengthIsEqualLimit() throws {
        searchApi.mockResult = .successValidResults
        let viewModel = SearchScreenModel()
        let searchText = "tt"
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, true)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)

        let search = self.expectation(description: "Search.")

        viewModel.$companies
            .dropFirst()
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                search.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [search], timeout: 10)

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, searchText)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, false)
        XCTAssertEqual(viewModel.companies.isEmpty, false)
    }

    func test_viewModelState_whenSearchTextLengthIsEqualLimitButWhiteSpaces_shouldReturnInitialState() throws {
        let viewModel = SearchScreenModel()
        let searchText = "  "
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)
    }

    func test_viewModelState_whenResultsArePresent_thenClearingTheSearchText_shouldReturInitialState() throws {
        searchApi.mockResult = .successValidResults
        let viewModel = SearchScreenModel()
        let searchText = "tt"
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, true)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)

        let search = self.expectation(description: "Search.")

        viewModel.$companies
            .dropFirst()
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                search.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [search], timeout: 10)

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, searchText)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, false)
        XCTAssertEqual(viewModel.companies.isEmpty, false)

        viewModel.searchText = ""

        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)
    }

    func test_viewModelState_whenReceivingError() throws {
        searchApi.mockResult = .failure
        let viewModel = SearchScreenModel()
        let searchText = "tt"
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, true)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)

        let search = self.expectation(description: "Search.")

        viewModel.$errorMessage
            .dropFirst()
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                search.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [search], timeout: 10)

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, searchText)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, true)
        XCTAssertNotEqual(viewModel.errorMessage, "")
    }

    func test_viewModelState_whenNoResultsForSearchText() throws {
        searchApi.mockResult = .successNoResults
        let viewModel = SearchScreenModel()
        let searchText = "tt"
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, true)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)

        let search = self.expectation(description: "Search.")

        viewModel.$companies
            .dropFirst()
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                search.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [search], timeout: 10)

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, searchText)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)
    }

    func test_viewModelState_whenSearchTextLengthIsEqualLimit_receivingInvalidResults_shouldNotFail() throws {
        searchApi.mockResult = .successValidResults
        let viewModel = SearchScreenModel()
        let searchText = "tt"
        viewModel.searchText = searchText

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, "")
        XCTAssertEqual(viewModel.isLoading, true)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, true)
        XCTAssertEqual(viewModel.companies.isEmpty, true)

        let search = self.expectation(description: "Search.")

        viewModel.$companies
            .dropFirst()
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                search.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [search], timeout: 10)

        XCTAssertEqual(viewModel.searchText, searchText)
        XCTAssertEqual(viewModel.mostRecentSearchText, searchText)
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.showError, false)
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isEmpty, false)
        XCTAssertEqual(viewModel.companies.isEmpty, false)
    }
}
