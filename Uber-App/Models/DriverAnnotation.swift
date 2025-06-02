//
//  DriverAnnotation.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import Firebase
import MapKit


class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let uid: String
    
    init(driver: User) {
        self.uid = driver.uid
        self.coordinate = CLLocationCoordinate2D(latitude: driver.coordinates.latitude,
                                                 longitude: driver.coordinates.longitude)
    }
    
    
}
