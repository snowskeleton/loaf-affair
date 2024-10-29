//
//  ContentView.swift
//  Loaf Affair
//
//  Created by snow on 10/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Household.name, order: .forward) private var homes: [Household]
    
    @State private var isPresentingNewDistribution = false
    
    var body: some View {
        TabView {
            Tab {
                AllHouseholdsView()
            } label: {
                Image(systemName: "house.fill")
            }
            Tab {
                AllDistributionsView()
            } label: {
                Image(systemName: "carrot.fill")
            }
        }
        .environment(\.horizontalSizeClass, .compact)
    }
}
