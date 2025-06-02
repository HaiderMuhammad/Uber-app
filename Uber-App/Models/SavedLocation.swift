//
//  SavedLocation.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import Firebase

struct SavedLocation: Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint
    
}
