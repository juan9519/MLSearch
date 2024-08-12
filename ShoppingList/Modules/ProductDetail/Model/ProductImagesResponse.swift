//
//  ProductImagesResponse.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import Foundation

// TODO: Search for an API that brings only images, not all the properties again
struct ProductImagesResponse: Decodable {
    var pictures = [MLPicture]()
}
