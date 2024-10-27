//
//  Item.swift
//  Loaf Affair
//
//  Created by snow on 10/27/24.
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
