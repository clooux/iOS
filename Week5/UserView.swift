//
//  UserView.swift
//  Week5
//
//  Created by user249775 on 1/7/24.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var auth: Authentication
    var body: some View {
        VStack(){
            Text("You are logged in!")
            Divider()
            Button(action: {
                auth.isLoggedIn = false
            }, label: {
                Text("Log out")
            })
        }
    }
}

#Preview {
    UserView()
}
