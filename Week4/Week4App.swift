//
//  Week4App.swift
//  Week4
//
//  Created by user249775 on 12/30/23.
//

import SwiftUI

@main
struct Week4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
