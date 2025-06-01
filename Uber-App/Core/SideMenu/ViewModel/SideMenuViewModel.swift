//
//  SideMenuViewModel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable, Identifiable {
    case trips
    case wallet
    case settings
    case messages
    
    var id: Int { return rawValue }
    
    var title: String {
        switch self {
        case .trips:    return "Your Trips"
        case .wallet:   return "Wallet"
        case .settings: return "Settings"
        case .messages: return "Messages"
        }
    }
    
    var imageName: String {
        switch self {
        case .trips:    return "list.bullet.rectangle"
        case .wallet:   return "creditcard"
        case .settings: return "gear"
        case .messages: return "bubble.left"
        }
    }
}
