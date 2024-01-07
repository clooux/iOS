//
//  ContentView.swift
//  Week5
//
//  Created by user249775 on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: Authentication
    var body: some View {
        if auth.isLoggedIn {
            UserView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
