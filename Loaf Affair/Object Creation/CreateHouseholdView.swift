//
//  CreateHouseholdView.swift
//  Loaf Affair
//
//  Created by snow on 10/27/24.
//

import SwiftUI
import SwiftData

struct CreateHouseholdView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
//    @Query(sort: \Household.name, order: .forward) private var homes: [Household]
    var home: Household?
    
    @State private var name: String = ""
    @State private var frequency: Double = 1.0
    @FocusState private var focuseName

    init () { }
    init(home: Household) {
        self.home = home
        _name = .init(initialValue: home.name)
        _frequency = .init(initialValue: home.frequency)
    }
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Enter name", text: $name)
                    .focused($focuseName)
                    .onAppear {
                        focuseName = true
                    }
            }
            
            Section(header: Text("Frequency")) {
                TextField("Frequency", value: $frequency, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            Button("Save") {
                save()
            }

        }
        .navigationTitle("Start an Affair")
    }
    
    fileprivate func save() {
        var newHousehold: Household
        if let home = home {
            newHousehold = home
        } else {
            newHousehold = Household()
        }
        
        newHousehold.name = name
        newHousehold.frequency = frequency
        
        if home == nil {
            modelContext.insert(newHousehold)
        }
        
        dismiss()
    }
    
}
