//
//  ProductDetailView.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import SwiftUI

struct ProductDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var router: MainRouter
    @StateObject private var viewModel: ProductDetailViewModel
    
    init(product: Product) {
        self._viewModel = StateObject(wrappedValue: ProductDetailViewModel(product))
    }
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Group {
                        Text(viewModel.product.title)
                            .font(.title)
                        
                        Text(viewModel.product.conditionToShow)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    productImages
                        .frame(minWidth: proxy.size.width, minHeight: 250)
                        .frame(maxWidth: proxy.size.width, maxHeight: 250)
                    
                    Group {
                        Text(viewModel.product.salePrice.formattedPrice)
                            .padding(.top)
                        
                        Text("Stock disponible: \(viewModel.product.availableQuantity)")
                        
                        Section {
                            descriptionView
                                .padding(.vertical)
                        } header: {
                            Text("Descripción")
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: proxy.size.width)
                
            }
            .frame(maxWidth: proxy.size.width)
        }
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
        .toast(isPresented: $viewModel.showError, model: viewModel.error)
    }
}

// MARK: - Subviews

private extension ProductDetailView {
    @ViewBuilder
    var productImages: some View {
        if viewModel.product.images.isEmpty {
            Image(systemName: "photo")
        } else {
            VStack {
                TabView(selection: $viewModel.selectedPicture) {
                    ForEach(viewModel.product.images, id: \.id) { mlImage in
                        if let imageURL = URL(string: mlImage.secureUrl) {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                            .tag(viewModel.product.images.firstIndex(of: mlImage) ?? 0)
                        }
                    }
                }
                .frame(minHeight: 250, maxHeight: 250)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                PageControlView(
                    itemsCount: viewModel.product.images.count,
                    currentIndex: viewModel.selectedPicture
                )
                .frame(maxWidth: 150)
                .animation(.easeInOut, value: viewModel.selectedPicture)
            }
        }
    }
    
    @ViewBuilder
    var descriptionView: some View {
        if let description = viewModel.product.description,
           !viewModel.descriptionLoading {
            Text(description)
        } else if viewModel.descriptionLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else {
            Text("No hay descripción")
        }
    }
}

#Preview {
    ProductDetailView(product: Product.testingProduct)
}
