//
//  ContentView.swift
//  Week3
//
//  Created by user249775 on 12/7/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    @State private var num = 10
    @State private var selectedTab = "Products"
    @State var cart: [Product] = []
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                List {
                    ForEach(products) { product in
                        NavigationLink {
                            VStack{
                                Text("\(product.name!)")
                                Button(){
                                    cart.append(product)
                                } label: {
                                    Label("Add to Cart", systemImage: "plus")
                                }
                            }
                        } label: {
                            Text(product.name!)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                Text("Select an item")
            }
            .tabItem {
                Label("Products", systemImage: "square.fill.text.grid.1x2")
            }
            .tag("Products")
            
            List {
                ForEach(cart) { item in
                    Text(item.name!)
                }
            }
            .tabItem {
                Label("Cart", systemImage: "cart")
            }
            .tag("Cart")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newProduct = Product(context: viewContext)
            newProduct.name = "Product" + String(num)
            num += 1
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
