//
//  Distribution.swift
//  Loaf Affair
//
//  Created by snow on 10/27/24.
//

import Foundation
import SwiftData

@Model
class Distribution: Identifiable {
    var id = UUID()
    var date: Date = Date()
    var notes: String = ""
    
    @Relationship
    var home: Household?

    init() { }
}
