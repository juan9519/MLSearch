//
//  Config.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

enum ConfigKey: String {
    case baseUrl = "BaseURL"
}

struct Config {
    static var baseUrl: String {
        return Config.value(forKey: .baseUrl)
    }
}

private extension Config {
    static let properties: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist")
        else {
            return [:]
        }
        
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? NSDictionary
        else {
            return [:]
        }
        
        return plist
    }()
    
    static func value(forKey key: ConfigKey) -> String {
        return Config.properties["\(key.rawValue)"] as! String
    }
    
    static func bool(forKey key: ConfigKey) -> Bool {
        return Config.properties["\(key.rawValue)"] as! Bool
    }
}
