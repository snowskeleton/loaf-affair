//
//  Loaf_AffairApp.swift
//  Loaf Affair
//
//  Created by snow on 10/27/24.
//

import SwiftUI
import SwiftData

@main
struct Loaf_AffairApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Household.self,
            Distribution.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
