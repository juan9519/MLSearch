//
//  MLPicture.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import Foundation

struct MLPicture: Identifiable, Equatable, Hashable, Decodable {
    let id: String
    let secureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case secureUrl = "secure_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.secureUrl = try! container.decode(String.self, forKey: .secureUrl)
    }
}
