//
//  ApiEndpoint.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

enum ApiEndpoint {
    // Product search
    case search(text: String, offset: Int? = nil)
    // Product property: Description
    case productDescription(id: String)
    // Product properties
    case productProperties(id: String)
}

// MARK: - Path

extension ApiEndpoint {
    var path: String {
        switch self {
        case .search(let text, let offset):
            var url = "/sites/MLU/search?q=\(text)"
            if let offset = offset {
                url = "\(url)&offset=\(offset)"
            }
            return url
        case .productDescription(let id):
            return "/items/\(id)/description"
        case .productProperties(let id):
            return "/items/\(id)?"
        }
    }
}

// MARK: - Method

extension ApiEndpoint {
    var method: String {
        switch self {
        case .search, .productDescription, .productProperties:
            return "GET"
        }
    }
}

// MARK: - Headers

extension ApiEndpoint {
    var headers: [String:String]? {
        switch self {
        case .search, .productDescription, .productProperties:
            return nil
        }
    }
}

// MARK: - Body

extension ApiEndpoint {
    var body: Data? {
        switch self {
        case .search, .productDescription, .productProperties:
            return nil
        }
    }
}
