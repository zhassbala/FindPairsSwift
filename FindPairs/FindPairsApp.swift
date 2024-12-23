//
//  FindPairsApp.swift
//  FindPairs
//
//  Created by Rassul Bessimbekov on 13.12.2024.
//

import SwiftUI
import SwiftData

@main
struct FindPairsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GameState.self,
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
