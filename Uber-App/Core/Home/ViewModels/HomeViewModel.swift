//
//  HomeViewModel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import SwiftUI
import Firebase


class HomeViewModel: ObservableObject {
    
    @Published var drivers =  [User]()
    
    init () {
        fetchDrivers()
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
}
