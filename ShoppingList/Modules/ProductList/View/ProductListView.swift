//
//  ProductListView.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import SwiftUI

struct ProductListView: View {
    // MARK: - Properties
    
    @EnvironmentObject private var router: MainRouter
    @StateObject private var viewModel: ProductListViewModel
    
    init(search: String, paging: Paging, products: [Product]) {
        self._viewModel = StateObject(
            wrappedValue: ProductListViewModel(search, paging: paging, products: products)
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.products, id: \.id) { product in
                    VStack {
                        ProductViewCell(product: product)
                            .frame(maxHeight: 70)
                        
                        Divider()
                    }
                    .frame(height: 90)
                    .padding(.horizontal)
                    .onTapGesture {
                        viewModel.selectItem(product)
                    }
                }
                
                if viewModel.moreResultsAvailable {
                    if !viewModel.loadingMoreResults {
                        Button("Más resultados") {
                            viewModel.getMoreResults()
                        }
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
            }
        }
        .navigationTitle("Resultados para: \(viewModel.searchText)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.pop()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
        .onChange(of: viewModel.navigate) {
            guard let newRoute = viewModel.navigate
            else {
                return
            }
            router.navigate(to: newRoute)
        }
        .onAppear {
            viewModel.navigate = nil
        }
        .toast(isPresented: $viewModel.showError, model: viewModel.error)
    }
}

#Preview {
    ProductListView(
        search: "Test",
        paging: Paging(total: 1000, primaryResults: 30, offset: 0, limit: 50),
        products: [
            Product.testingProduct,
            Product.testingProduct,
            Product.testingProduct
        ]
    )
}
