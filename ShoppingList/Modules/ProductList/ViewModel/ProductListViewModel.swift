//
//  ProductListViewModel.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    // MARK: - Properties
    
    var paging: Paging
    var searchText: String
    @Published var products: [Product]
    @Published var showError = false
    @Published var loadingMoreResults = false
    @Published var error: ToastModel?
    @Published var navigate: MainRouter.Route?
    var moreResultsAvailable: Bool {
        return products.count < 999
    }
    
    init(_ searchText: String, paging: Paging, products: [Product]) {
        self.searchText = searchText
        self.paging = paging
        self.products = products
    }
}

// MARK: - Public methods

extension ProductListViewModel {
    func selectItem(_ item: Product) {
        navigate = .productDetail(product: item)
    }
    
    func getMoreResults() {
        loadingMoreResults = true
        Task {
            do {
                let response: ProductSearchResponse = try await NetworkManager.shared.fetchRequest(
                    .search(text: searchText, offset: products.count + 1)
                )
                loadingMoreResults = false
                self.products.append(contentsOf: response.results)
            } catch {
                loadingMoreResults = false
#if DEBUG
                print("ProductListViewModel - \(error.localizedDescription)")
#endif
                self.error = ToastModel(
                    message: UserErrors.moreResultsError.localizedDescription,
                    type: .error
                )
                showError = true
            }
        }
    }
}
