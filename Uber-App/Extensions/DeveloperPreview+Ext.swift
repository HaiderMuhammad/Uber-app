//
//  DeveloperPreview+Ext.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import SwiftUI
import Firebase


extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}


class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    
    let mockTrip = Trip(
        id: NSUUID().uuidString,
        passengerUid: NSUUID().uuidString,
        driverUid: NSUUID().uuidString,
        passengerName: "Haider Muhammad",
        driverName: "Ahmed",
        passengerLocation: .init(latitude: 37.123, longitude: -122.1),
        driverLocation: .init(latitude: 37.123, longitude: -122.1),
        pickupLocationName: "Apple Store",
        dropoffLocationName: "Starbucks",
        pickupLocationAddress: "123 Main St, San Francisco",
        pickupLocation: .init(latitude: 37.123, longitude: -122.1),
        dropoffLocation: .init(latitude: 37.123, longitude: -122.1),
        tripCost: 15.4,
        distanceToPassenger: 1000,
        travelTimeToPasseneger: 40
    )
     
    let mockUser = User(
        fullName: "Haider Muhammad",
        email: "haider@gmail.com",
        uid: NSUUID().uuidString,
        coordinates: GeoPoint(latitude: 37.38, longitude: -122.05),
        accountType: .passenger,
        homeLocation: nil,
        workLocation: nil
    )
}
