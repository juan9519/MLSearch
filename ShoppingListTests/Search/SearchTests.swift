//
//  SearchTest.swift
//  ShoppingListTests
//
//  Created by Juan Rodriguez on 12/8/24.
//

import XCTest
import Combine

@MainActor
final class SearchTest: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Empty search test
    
    func testEmptySearch() {
        let viewModel = SearchViewModel()
        viewModel.searchText = .empty
        viewModel.searchProduct()
        
        XCTAssertFalse(viewModel.loading)
        XCTAssertFalse(viewModel.showError)
        XCTAssertNil(viewModel.error)
        XCTAssertNil(viewModel.navigate)
    }
    
    // MARK: - Correct search test

    func testCorrectSearch() {
        let expectation = expectation(description: "Expect to get products from search")
        let viewModel = SearchViewModel()
        viewModel.searchText = "iPhone"
        viewModel.searchProduct()
        XCTAssertTrue(viewModel.loading)
        
        viewModel.$navigate
            .sink { newValue in
                if newValue != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 2)
        XCTAssertFalse(viewModel.loading)
        XCTAssertFalse(viewModel.showError)
        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.navigate)
    }
}
