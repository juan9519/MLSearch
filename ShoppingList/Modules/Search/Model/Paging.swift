//
//  Paging.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

struct Paging: Codable, Equatable, Hashable {
    let total: Int
    let primaryResults: Int
    let offset: Int
    let limit: Int
    
    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset
        case limit
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(Int.self, forKey: .total)
        self.primaryResults = try container.decode(Int.self, forKey: .primaryResults)
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.limit = try container.decode(Int.self, forKey: .limit)
    }
    
    // Testing purposes
    init(total: Int, primaryResults: Int, offset: Int, limit: Int) {
        self.total = total
        self.primaryResults = primaryResults
        self.offset = offset
        self.limit = limit
    }
}
