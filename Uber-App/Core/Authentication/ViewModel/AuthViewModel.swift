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
}
