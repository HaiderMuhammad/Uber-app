//
//  Item.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/30/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
