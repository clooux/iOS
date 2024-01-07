//
//  Authentication.swift
//  Week5
//
//  Created by user249775 on 1/7/24.
//

import Foundation

class Authentication: ObservableObject {
    private let serverURL = "http://127.0.0.1:3000"
    
    @Published var isLoggedIn: Bool = false
    
    func logIn(username: String, password: String) {
        guard let url = URL(string: "\(serverURL)/login") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        guard let json = try? JSONSerialization.data(withJSONObject: user) else {
            return
        }
        
        request.httpBody = json
        
        let requestTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                self.isLoggedIn = true
            }
            
        }
        requestTask.resume()
    }
}
