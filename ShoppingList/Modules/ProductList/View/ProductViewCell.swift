//
//  ProductViewCell.swift
//  ShoppingList
//
//  Created by Juan Rodriguez on 11/8/24.
//

import SwiftUI

struct ProductViewCell: View {
    // MARK: - Properties
    
    let product: Product
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 15) {
            thumbnail
                .frame(maxWidth: 70, maxHeight: 70)
                .clipShape(RoundedRectangle(cornerRadius: StyleConstants.cornerRadius))
            
            VStack(alignment: .leading) {
                Text(product.title)
                
                Text(product.salePrice.formattedPrice)
                
                Text("Condición: \(product.conditionToShow)")
                Text("Quedan: \(product.availableQuantity)")
            }
            .font(.footnote)
            
            Spacer()
        }
    }
}

// MARK: - Subviews

private extension ProductViewCell {
    @ViewBuilder
    var thumbnail: some View {
        if let imageURL = URL(string: product.thumbnail) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
        } else {
            Image(systemName: "photo")
        }
    }
}

#Preview {
    ProductViewCell(
        product: Product.testingProduct
    )
}
