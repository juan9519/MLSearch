//
//  MainRouter.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import SwiftUI

class MainRouter: ObservableObject {
    enum Route: Hashable {
        static func == (lhs: MainRouter.Route, rhs: MainRouter.Route) -> Bool {
            lhs.hashValue == rhs.hashValue
        }
        
        case search
        case list(search: String, paging: Paging, products: [Product])
        case productDetail(product: Product)
    }
    
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
}
