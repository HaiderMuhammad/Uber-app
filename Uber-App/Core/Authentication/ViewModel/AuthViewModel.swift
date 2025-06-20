//
//  AuthenticationViewModel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine


class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    private let service = UserService.shared
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { result, error in
            if let error = error {
                print("Falied to Sign in user: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("Sign in successfully \(result!.user.uid)")
            
        }
    }
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        
        guard let location = LocationManager.shared.userLocation else { return  }
        
        Auth.auth().createUser(withEmail: email.lowercased(), password: password) { result, error in
            if let error = error {
                print("Failed to Sign up user: \(error.localizedDescription) ")
                return
            }
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser
            
            let user = User(
                fullName: fullname,
                email: email,
                uid: firebaseUser.uid, 
                coordinates: GeoPoint(latitude: location.latitude,
                                      longitude: location.longitude),
                accountType: .driver
            )
            
            
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
            
            self.currentUser = user
            
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Failed to signout user: \(error.localizedDescription)")
        }
    }
    
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
            }
            .store(in: &cancellables)
    }
}
