//
//  ToastModel.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import Foundation

struct ToastModel: Identifiable {
    enum ToastType {
        case success
        case error
        case info
    }
    
    let id = UUID()
    let message: String
    let dissapearsAutomatically: Bool
    let loading: Bool
    let type: ToastType
    
    init(
        message: String,
        dissapearsAutomatically: Bool = true,
        loading: Bool = false,
        type: ToastType = .success
    ) {
        self.message = message
        self.dissapearsAutomatically = dissapearsAutomatically
        self.loading = loading
        self.type = type
    }
}
