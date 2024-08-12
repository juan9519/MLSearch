//
//  ToastView+ViewExtension.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let model: ToastModel
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                
                if isPresented {
                    ToastView(model: model)
                        .padding()
                        .onAppear {
                            prepareDismiss()
                        }
                }
            }
        }
    }
    
    func prepareDismiss() {
        if model.dissapearsAutomatically {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isPresented = false
                }
            }
        }
    }
}

extension View {
    func toast(
        isPresented: Binding<Bool>,
        model: ToastModel?
    ) -> some View {
        self.modifier(
            ToastModifier(
                isPresented: isPresented,
                model: model ?? .init(message: .empty)
            )
        )
    }
    
    func toast(
        isPresented: Binding<Bool>,
        message: String
    ) -> some View {
        self.modifier(
            
            ToastModifier(
                isPresented: isPresented,
                model: .init(message: message)
            )
        )
    }
}
