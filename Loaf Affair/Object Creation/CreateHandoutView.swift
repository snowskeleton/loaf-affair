//
//  CreateHandoutView.swift
//  Loaf Affair
//
//  Created by snow on 10/28/24.
//

import SwiftUI
import SwiftData

struct CreateHandoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var distribution: Distribution?
    var home: Household?

    @State private var date: Date = Date()
    @State private var notes: String = ""
    
    init(home: Household) {
        self.home = home
    }
    
    init(distribution: Distribution) {
        self.distribution = distribution
        self.home = distribution.home
        _date = .init(initialValue: distribution.date)
        _notes = .init(initialValue: distribution.notes)
    }
    
    var body: some View {
        Form {
            Section {
                DatePicker("Date", selection: $date)
            }
            Section {
                TextField("Notes", text: $notes)
            }
            Section {
                Button("Save") {
                    save()
                }
            }
        }
        .navigationTitle("Setup Rendezvous")
    }
    fileprivate func save() {
        var newDistribution: Distribution
        if let distribution = distribution {
            newDistribution = distribution
        } else {
            newDistribution = Distribution()
        }
        
        newDistribution.notes = notes
        newDistribution.date = date
        newDistribution.home = home
        
        if distribution == nil {
            modelContext.insert(newDistribution)
        }
        
        dismiss()
    }
}
