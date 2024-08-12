//
//  ProductSearchResponse.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

struct ProductSearchResponse: Decodable {
    let paging: Paging
    var results: [Product] = []
}


