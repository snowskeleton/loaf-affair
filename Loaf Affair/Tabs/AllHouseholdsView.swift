//
//  AllHouseholdsView.swift
//  Loaf Affair
//
//  Created by snow on 10/28/24.
//

import SwiftUI
import SwiftData

struct AllHouseholdsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Household.name, order: .forward) private var homes: [Household]
    
    @State private var isPresentingNewDistribution = false
    @State private var tappedHome: Household? = nil
    
    var body: some View {
        NavigationStack {
            List(homes) { home in
                HStack {
                    NavigationLink {
                        CreateHandoutView(home: home)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(home.name)
                                .font(.headline)
                            Text("Frequency: \(home.frequency, specifier: "%.1f")")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                    }
                    Button("Edit") {
                        tappedHome = home
                    }
                    .buttonStyle(BorderlessButtonStyle())

                }
                .swipeActions {
                    Button("Quickie") {
                        let newDistribution = Distribution()
                        newDistribution.date = Date()
                        newDistribution.home = home
                        modelContext.insert(newDistribution)
                    }
                    .tint(.green)
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        CreateHouseholdView()
                    } label: {
                        Text("New")
                    }
                }
            }
            .navigationTitle("Loaf Affair")
            .navigationDestination(item: $tappedHome) { home in
                CreateHouseholdView(home: home)
            }
        }
    }
}
