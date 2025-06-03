//
//  UberLocation.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import CoreLocation


struct UberLocation: Identifiable {
    let id = NSUUID().uuidString
    let title: String
    let coordinate: CLLocationCoordinate2D
}
