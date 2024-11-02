//
//  AllDistributionsView.swift
//  Loaf Affair
//
//  Created by snow on 10/28/24.
//

import SwiftUI
import SwiftData

struct AllDistributionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Distribution.date, order: .reverse) private var distributions: [Distribution]
    
    @State private var searchText: String = ""
    var filteredDistributions: [Distribution] {
        if searchText.isEmpty { return distributions }
        return distributions.filter {
            ($0.home?.name ?? "").lowercased().contains(searchText.lowercased())
        }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredDistributions) { distribution in
                    NavigationLink {
                        CreateHandoutView(distribution: distribution)
                    } label: {
                        HStack {
                            Text(distribution.home?.name ?? "No name")
                            Spacer()
                            Text("\(distribution.date, formatter: DateFormatter.short)")
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .searchable(text: $searchText)
            .navigationTitle("Rendezvouses")
        }
    }
    fileprivate func delete(at offsets: IndexSet) {
        for index in offsets {
            let distribution = distributions[index]
            modelContext.delete(distribution)
        }
    }
}

