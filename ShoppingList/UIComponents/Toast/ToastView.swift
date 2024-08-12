//
//  ToastView.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import SwiftUI

struct ToastView: View {
    let model: ToastModel
    
    var body: some View {
        HStack {
            if model.loading {
                ProgressView()
            }
            
            Text(model.message)
        }
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(StyleConstants.cornerRadius)
            .shadow(radius: 10)
            .transition(.moveFromBottom)
            .animation(.easeInOut(duration: 0.5))
    }
    
    var backgroundColor: Color {
        switch model.type {
        case .success:
            return Color.green.opacity(0.8)
        case .error:
            return Color.red.opacity(0.8)
        case .info:
            return .gray.opacity(0.8)
        }
    }
}

#Preview {
    ToastView(model: .init(message: "Test"))
}
