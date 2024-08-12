//
//  CustomTransitions.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import SwiftUI

extension AnyTransition {
    static var moveFromTop: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .top).combined(with: .opacity)
        )
    }
    
    static var moveFromBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }
}
