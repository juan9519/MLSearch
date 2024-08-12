//
//  Price.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import Foundation

struct Price: Decodable, Equatable, Hashable {
    let amount: Double
    let currencyId: MLCurrency
    
    enum CodingKeys: String, CodingKey {
        case amount
        case currencyId = "currency_id"
    }
    
    enum MLCurrency: String, Codable {
        case USD
        case UYU
        
        var symbol: String {
            switch self {
            case .USD:
                return "U$S"
            case .UYU:
                return "$"
            }
        }
    }
}

extension Price {
    var formattedPrice: String {
        return String(format: "\(currencyId.symbol) %.2f", amount)
    }
}
