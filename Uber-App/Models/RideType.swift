//
//  RideType.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import Foundation


enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX:
            return "UberX"
        case .uberBlack:
            return "UberBlack"
        case .uberXL:
            return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX:
            return "car"
        case .uberBlack:
            return "car"
        case .uberXL:
            return "car"
        }
    }
}
