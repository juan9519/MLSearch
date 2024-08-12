//
//  UserErrors.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import Foundation

enum UserErrors: Error {
    case productSearchError
    case productDetailError
    case moreResultsError
    
    var localizedDescription: String {
        switch self {
        case .productSearchError:
            return "Ha ocurrido un error en la búsqueda del producto"
        case .productDetailError:
            return "Ha ocurrido un error al obtener uno o más detalles del producto"
        case .moreResultsError:
            return "Ha ocurrido un error al obtener más resultados"
        }
    }
}
