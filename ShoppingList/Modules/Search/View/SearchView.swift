//
//  SearchView.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var router: MainRouter
    @StateObject private var viewModel = SearchViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("Busca tus productos favoritos")
                        .font(.callout)
                }
            }
        }
        .padding()
        .searchable(text: $viewModel.searchText, prompt: "Buscar")
        .navigationTitle("Buscar")
        .onSubmit(of: .search) {
            viewModel.searchProduct()
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
    SearchView()
}
