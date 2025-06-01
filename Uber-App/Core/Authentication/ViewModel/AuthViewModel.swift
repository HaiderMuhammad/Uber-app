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
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { result, error in
            if let error = error {
                print("Falied to Sign in user: \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
            print("Sign in successfully \(result!.user.uid)")
            
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        Auth.auth().createUser(withEmail: email.lowercased(), password: password) { result, error in
            if let error = error {
                print("Failed to Sign up user: \(error.localizedDescription) ")
                return
            }
            
            self.userSession = result?.user
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("Failed to signout user: \(error.localizedDescription)")
        }
    }
}
