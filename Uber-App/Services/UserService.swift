//
//  UserService.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import Firebase
import FirebaseAuth



class UserService: ObservableObject {
    
    static let shared = UserService()
    
    @Published var user: User?
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid)
            .getDocument {  snapshot, _ in
                
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                self.user = user
        }
    }
}
