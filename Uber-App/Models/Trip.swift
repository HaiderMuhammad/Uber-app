//
//  Trip.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import Firebase

enum TripState: Int, Codable {
    case requested
    case rejected
    case accepted
    
}


struct Trip: Identifiable, Codable {
    let id: String
    let passengerUid: String
    let driverUid: String
    let passengerName: String
    let driverName: String
    let passengerLocation: GeoPoint
    let driverLocation: GeoPoint
    let pickupLocationName: String
    let dropoffLocationName: String
    let pickupLocationAddress: String
    let pickupLocation: GeoPoint
    let dropoffLocation: GeoPoint
    let tripCost: Double
    
    var distanceToPassenger: Double
    var travelTimeToPasseneger: Int
    var state: TripState
}
