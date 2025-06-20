//
//  USer.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import Firebase


enum AccountType: Int, Codable {
    case passenger
    case driver
}


struct User: Codable {
    let fullName: String
    let email: String
    let uid: String
    var coordinates: GeoPoint 
    var accountType: AccountType
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
 
