//
//  CategoryView.swift
//  Week4
//
//  Created by user249775 on 12/30/23.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var category: Category
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var products: FetchedResults<Product>
    
    var body: some View {
        VStack {
            Text(category.name ?? "")
                .font(.title)
            Spacer()
            
            List {
                ForEach(products) { product in
                    HStack{
                        NavigationLink(product.name!, destination: ProductView(product: product))
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)    }
    }
}
