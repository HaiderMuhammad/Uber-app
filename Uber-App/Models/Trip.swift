//
//  Trip.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import Firebase
import FirebaseFirestore

enum TripState: Int, Codable {
    case requested
    case rejected
    case accepted
    case passengerCancelled
    case driverCancelled
    
    
}


struct Trip: Identifiable, Codable {
    @DocumentID var tripId: String?
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
    
    var id: String {
        return tripId ?? ""
    }
}
