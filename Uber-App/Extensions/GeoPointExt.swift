//
//  GeoPOint.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import Firebase
import CoreLocation



extension GeoPoint {
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: CLLocationDegrees(self.latitude),
            longitude: CLLocationDegrees(self.longitude)
        )
    }
}
