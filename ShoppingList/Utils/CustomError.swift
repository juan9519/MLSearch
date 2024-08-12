//
//  CustomError.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import Foundation

enum CustomError: Error {
    case unknownError
    case emptySearchError
    case responseCodeError(code: Int)
    case customError(text: String)
    
    var localizedDescription: String {
        switch self {
        case .unknownError:
            return "There was an unexpected error"
        case .emptySearchError:
            return "Search field is empty"
        case .responseCodeError(let code):
            return "Response code error \(code)"
        case .customError(let text):
            return text
        }
    }
}


