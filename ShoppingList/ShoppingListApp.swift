//
//  ShoppingListApp.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import SwiftUI

@main
struct ShoppingListApp: App {
    @StateObject private var router = MainRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SearchView()
                    .navigationDestination(for: MainRouter.Route.self) { route in
                        switch route {
                        case .search:
                            SearchView()
                        case .list(let search, let paging, let products):
                            ProductListView(search: search, paging: paging, products: products)
                        case .productDetail(let product):
                            ProductDetailView(product: product)
                        }
                    }
            }
            .environmentObject(router)
            
        }
    }
}
