//
//  Week3App.swift
//  Week3
//
//  Created by user249775 on 12/7/23.
//

import SwiftUI

@main
struct Week3App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
