//
//  extension DateFormatter.swift
//  Loaf Affair
//
//  Created by Isaac Lyons on 10/31/24.
//

import Foundation
import SwiftUI

extension DateFormatter {
    static let short: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
