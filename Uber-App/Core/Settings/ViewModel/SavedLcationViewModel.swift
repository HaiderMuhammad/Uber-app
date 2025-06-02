//
//  SavedLcationViewMdel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import Foundation


enum SavedLcationViewModel: Int, CaseIterable, Identifiable {
    case home
    case work
    
    var id: Int { return self.rawValue }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .work:
            return "Work"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "house.cricle.fill"
        case .work:
            return "archivebox.cricle.fill"
        }
    }
    
    var subtitle: String {
        switch self {
        case .home:
            return "Add Home"
        case .work:
            return "Add Work"
        }
    }
}
