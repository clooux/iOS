//
//  LoginView.swift
//  Week5
//
//  Created by user249775 on 1/7/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @Environment var auth: Authentication
    
    var body: some View {
        NavigationStack(){
            VStack(){
                TextField("email", text: $username)
                SecureField("password", text: $password)
                Button(action:  {auth.logIn(username: username, password: password)}, label: {
                    Text("Log in")
                })
            }
        }
    }
}

#Preview {
    LoginView()
}
