//
//  PageControlView.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 12/8/24.
//

import SwiftUI

struct PageControlView: View {
    // MARK: - Properties
    
    let itemsCount: Int
    var currentIndex: Int
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(0..<itemsCount, id: \.self) { index in
                        if index == currentIndex {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.primary)
                                .frame(width: 20, height: 8)
                                .transition(.scale)
                        } else {
                            Circle()
                                .fill(Color.secondary)
                                .frame(width: 8, height: 8)
                                .transition(.scale)
                        }
                    }
                    .onChange(of: currentIndex) { newIndex in
                        withAnimation {
                            scrollViewProxy.scrollTo(newIndex, anchor: .center)
                        }
                    }
                }
                .frame(height: 10)
            }
        }
        
    }
}

#Preview {
    PageControlView(itemsCount: 3, currentIndex: 2)
}
