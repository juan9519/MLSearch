//
//  Product.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

struct Product: Decodable, Equatable, Hashable {
    let id: String
    let title: String
    let condition: Condition
    let thumbnail: String
    let availableQuantity: Int
    let salePrice: Price
    var description: String?
    var images = [MLPicture]()
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case condition
        case thumbnail
        case availableQuantity = "available_quantity"
        case salePrice = "sale_price"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.condition = try container.decode(Condition.self, forKey: .condition)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.availableQuantity = try container.decode(Int.self, forKey: .availableQuantity)
        self.salePrice = try container.decode(Price.self, forKey: .salePrice)
    }
    
    enum Condition: String, Decodable {
        case new
        case used
        case notSpecified = "not_specified"
    }
}

extension Product {
    var conditionToShow: String {
        switch condition {
        case .new:
            return "Nuevo"
        case .used:
            return "Usado"
        case .notSpecified:
            return .empty
        }
    }
    
    mutating func addDescription(_ description: String) {
        self.description = description
    }
    
    mutating func addImages(_ images: [MLPicture]) {
        self.images = images
    }
}

// MARK: - Testing purposes

extension Product {
    init(id: String, title: String, condition: Condition, thumbnail: String, availableQuantity: Int, price: Price) {
        self.id = id
        self.title = title
        self.condition = condition
        self.thumbnail = thumbnail
        self.availableQuantity = availableQuantity
        self.salePrice = price
    }
    
    static var testingProduct: Product {
        return Product(
            id: "MLUTEST",
            title: "Test título",
            condition: .new,
            thumbnail: "http://http2.mlstatic.com/D_814213-MLU74618649923_022024-I.jpg",
            availableQuantity: 1,
            price: Price(amount: 300, currencyId: .USD)
        )
    }
}

