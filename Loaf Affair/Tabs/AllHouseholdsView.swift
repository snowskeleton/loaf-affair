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
    
    @State private var editHome: Household? = nil
    
    @State private var searchText: String = ""
    var filteredHouses: [Household] {
        if searchText.isEmpty { return homes }
        return homes.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    var sortedHouses: [Household] {
        filteredHouses.sorted {
            // Calculate days since the last distribution
            let lastDistributionDate1 = $0.distributions?.last?.date ?? Date.distantPast
            let lastDistributionDate2 = $1.distributions?.last?.date ?? Date.distantPast
            let daysSinceLast1 = Date().timeIntervalSince(lastDistributionDate1) / (60 * 60 * 24)
            let daysSinceLast2 = Date().timeIntervalSince(lastDistributionDate2) / (60 * 60 * 24)
            
            // Calculate the custom metric by multiplying days since last distribution by frequency
            let metric1 = daysSinceLast1 * $0.frequency
            let metric2 = daysSinceLast2 * $1.frequency
            
            // Sort in ascending order based on the custom metric
            return metric1 > metric2
        }
    }
    
    var body: some View {
        NavigationStack {
            List(sortedHouses) { home in
                HStack {
                    NavigationLink {
                        CreateHandoutView(home: home)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(home.name)
                                .font(.headline)
                            Text("Frequency: \(home.frequency, specifier: "%.1f")")
                                .font(.subheadline)
                            
                            // Show last distribution date or "No distributions yet"
                            if let lastDistribution = home.distributions?.last {
                                Text("Last given on: \(lastDistribution.date, formatter: DateFormatter.short)")
                                    .font(.subheadline)
                            } else {
                                Text("No distributions yet")
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                    }
                    
                    Button("Edit") {
                        editHome = home
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
            .searchable(text: $searchText)
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
            .navigationDestination(item: $editHome) { home in
                CreateHouseholdView(home: home)
            }
        }
    }
}
