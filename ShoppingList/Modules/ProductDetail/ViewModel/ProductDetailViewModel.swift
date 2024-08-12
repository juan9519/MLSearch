//
//  ProductDetailViewModel.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import Foundation

@MainActor
class ProductDetailViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var product: Product
    @Published var imagesLoading = false
    @Published var descriptionLoading = false
    @Published var showError = false
    @Published var error: ToastModel?
    @Published var selectedPicture = 0
    
    init(_ product: Product) {
        self.product = product
        getProductData()
    }
}

// MARK: - Public methods

extension ProductDetailViewModel {
    
}

// MARK: - Private methods

private extension ProductDetailViewModel {
    func getProductData() {
        imagesLoading = true
        descriptionLoading = true
        
        Task {
            do {
                async let imagesResponse: ProductImagesResponse = NetworkManager.shared.fetchRequest(
                    .productProperties(id: product.id)
                )
                async let descriptionResponse: ProductDescriptionResponse = NetworkManager.shared.fetchRequest(
                    .productDescription(id: product.id)
                )
                
                let (imagesResponseData, descriptionResponseData) = try await (imagesResponse, descriptionResponse)
                imagesLoading = false
                descriptionLoading = false
                
                self.product.addImages(imagesResponseData.pictures)
                self.product.addDescription(descriptionResponseData.description)
                
            } catch {
                descriptionLoading = false
                imagesLoading = false
#if DEBUG
                print("ProductDetailViewModel - \(error.localizedDescription)")
#endif
                self.error = ToastModel(
                    message: UserErrors.productDetailError.localizedDescription,
                    type: .error
                )
                showError = true
            }
        }
    }
}
