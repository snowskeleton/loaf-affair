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
    
    var home: Household?
    
    @State private var date: Date = Date()
    @State private var notes: String = ""
    
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
        let newDistribution = Distribution()
        newDistribution.notes = notes
        newDistribution.date = date
        newDistribution.home = home
        modelContext.insert(newDistribution)
        dismiss()
    }
}
