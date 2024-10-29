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
    @Query(sort: \Distribution.date, order: .forward) private var distributions: [Distribution]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(distributions) { distribution in
                HStack {
                    VStack(alignment: .leading) {
                        Text(distribution.date.description)
                        Text(distribution.home?.name ?? "No name")
                    }
                }
            }
                .onDelete(perform: delete)

            }
            .navigationTitle("Rendezvouses")
        }
    }
    fileprivate func delete(at offsets: IndexSet) {
        for index in offsets {
            let distribution = distributions[index]
            modelContext.delete(distribution)
        }
//        try? modelContext.save()  Save changes to persist deletion
    }
}

