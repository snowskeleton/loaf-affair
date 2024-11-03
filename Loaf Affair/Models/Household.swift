//
//  Household.swift
//  Loaf Affair
//
//  Created by snow on 10/28/24.
//

import Foundation
import SwiftData

@Model
class Household: Identifiable {
    var id = UUID()
    var name: String = ""
    var frequency: Double = 1
    
    @Relationship
    var distributions: [Distribution]? = []
    
    var lastDistribution: Distribution? {
        distributions?.sorted(by: { $0.date > $1.date }).first
    }
    
    init() { }
}
