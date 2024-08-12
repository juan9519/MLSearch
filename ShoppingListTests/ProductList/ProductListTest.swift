//
//  ProductListTest.swift
//  ShoppingListTests
//
//  Created by Juan Rodriguez on 12/8/24.
//

import XCTest
import Combine

@MainActor
final class ProductListTest: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Selecting item test
    
    func testSelectItem() {
        let viewModel = ProductListViewModel(
            "iPhone",
            paging: .init(total: 1000, primaryResults: 49, offset: 0, limit: 50),
            products: [
                Product.testingProduct,
                Product.testingProduct
                
            ]
        )
        
        viewModel.selectItem(viewModel.products[0])
        
        XCTAssertFalse(viewModel.showError)
        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.navigate)
    }
    
    // MARK: - More results test
    
    func testLoadingMoreResults() {
        let expectation = expectation(description: "More results expected")
        let initialProducts = [
            Product.testingProduct,
            Product.testingProduct
        ]
        let viewModel = ProductListViewModel(
            "iPhone",
            paging: .init(total: 1000, primaryResults: 49, offset: 0, limit: 50),
            products: [
                
            ]
        )
        
        XCTAssertFalse(viewModel.loadingMoreResults)
        viewModel.getMoreResults()
        XCTAssertTrue(viewModel.loadingMoreResults)
        
        viewModel.$loadingMoreResults
            .sink { newValue in
                if newValue == false {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 2)
        
        XCTAssertFalse(viewModel.showError)
        XCTAssertNil(viewModel.error)
        XCTAssertNotEqual(initialProducts, viewModel.products)
    }
   
}
