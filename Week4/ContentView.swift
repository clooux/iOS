//
//  ContentView.swift
//  Week4
//
//  Created by user249775 on 12/30/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    @State var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationView {
                List {
                    ForEach(categories) { category in
                        HStack{
                            NavigationLink(category.name!, destination: CategoryView(category: category))
                        }
                    }
                }
            }.tabItem {
                Image(systemName: "list.dash")
                Text("Categories")
            }.tag(0)
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
