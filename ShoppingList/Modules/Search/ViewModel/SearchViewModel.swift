//
//  SearchViewModel.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var searchText: String = .empty
    @Published var loading = false
    @Published var showError = false
    @Published var error: ToastModel?
    @Published var navigate: MainRouter.Route?
    
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - Public methods

extension SearchViewModel {
    func searchProduct() {
        guard !searchText.isEmpty
        else {
#if DEBUG
            print("SearchViewModel - \(CustomError.emptySearchError)")
#endif
            return
        }
        
        error = nil
        loading = true
        
        Task {
            do {
                let response: ProductSearchResponse = try await NetworkManager.shared.fetchRequest(
                    .search(text: searchText)
                )
                loading = false
                navigate = .list(
                    search: searchText,
                    paging: response.paging,
                    products: response.results
                )
                
            } catch {
                loading = false
#if DEBUG
                print("SearchViewModel - \(error.localizedDescription)")
#endif
                self.error = ToastModel(
                    message: UserErrors.productSearchError.localizedDescription, 
                    type: .error
                )
                showError = true
            }
        }
    }
}
