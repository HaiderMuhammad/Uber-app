//
//  AuthenticationViewModel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import Foundation
import FirebaseAuth


class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to Sign up user: \(error.localizedDescription) ")
                return
            }
            
            
        }
    }
}
