//
//  ProductDetailTest.swift
//  ShoppingListTests
//
//  Created by Juan Rodriguez on 12/8/24.
//

import XCTest
import Combine

@MainActor
final class ProductDetailTest: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Getting product data test
    
    func testGetProductData() {
        let imagesExpectation = expectation(description: "Product images expected")
        let descriptionExpectation = expectation(description: "Product description expected")
        let viewModel = ProductDetailViewModel(.testingProduct)
        
        XCTAssertFalse(viewModel.showError)
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.imagesLoading)
        XCTAssertTrue(viewModel.descriptionLoading)
        XCTAssertTrue(viewModel.product.images.isEmpty)
        XCTAssertNil(viewModel.product.description)
        
        viewModel.$imagesLoading
            .sink { newValue in
                if newValue == false {
                    imagesExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$descriptionLoading
            .sink { newValue in
                if newValue == false {
                    descriptionExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 2)
        
        XCTAssertFalse(viewModel.imagesLoading)
        XCTAssertFalse(viewModel.descriptionLoading)
        XCTAssertFalse(viewModel.product.images.isEmpty)
        XCTAssertNotNil(viewModel.product.description)   
    }
   
}
