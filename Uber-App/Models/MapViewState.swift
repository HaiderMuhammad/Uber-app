//
//  MapViewState.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import Foundation


enum MapViewState {
    case noInput
    case searchingForLocation
    case locationSelected
    case polylineAdded
    case tripRequested
    case tripAccepted
    case tripRejected
    case tripCancelldByPassenger
    case tripCancelldByDriver
    
}
