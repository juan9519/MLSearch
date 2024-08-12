//
//  NetworkManager.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

// TODO: - This networking manager can be improved with specific status code handling, intersector, etc...

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRequest<T:Decodable>(_ endpoint: ApiEndpoint) async throws -> T {
        guard let url = URL(string: "\(Config.baseUrl)\(endpoint.path)")
        else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
#if DEBUG
            print("NetworkManager - Incorrect status code. CODE:\(response.statusCode)")
#endif
            throw CustomError.responseCodeError(code: response.statusCode)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
#if DEBUG
            print("NetworkManager - Error decoding data \(error.localizedDescription)")
#endif
            throw error
        }
        
    }
}
