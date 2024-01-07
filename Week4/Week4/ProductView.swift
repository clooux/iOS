//
//  ProductView.swift
//  Week4
//
//  Created by user249775 on 12/30/23.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    var body: some View {
        VStack {
            Text("Product Name: \(product.name ?? "")")
                .padding()
            
            
            Spacer()
        }
        .navigationBarTitle("Product Details", displayMode: .inline)
    }
}

