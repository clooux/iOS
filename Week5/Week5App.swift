//
//  Week5App.swift
//  Week5
//
//  Created by user249775 on 1/7/24.
//

import SwiftUI

@main
struct Week5App: App {
    @StateObject var auth = Authentication()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(auth)
        }
    }
}
