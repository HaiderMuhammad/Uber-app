//
//  HomeViewModel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var drivers =  [User]()
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    var currentUser: User?
    
    init () {
        fetchUser()
    }
    
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments {  snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                do {
                    let drivers = try documents.map { try $0.data(as: User.self) }
                    self.drivers = drivers
                    
                } catch {
                    print("Failed to decode users: \(error)")
                }
            }
    }
    
    
    func fetchUser() {
        service.$user
            .sink { user in
                guard let user = user else { return }
                self.currentUser = user
                guard user.accountType == .passenger else { return }
                self.fetchDrivers()
            }
            .store(in: &cancellables)
    }
}
