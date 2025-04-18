//  ai_projectApp.swift
//  ai_project
//
//  Created by Erwin on 24.02.25.

import SwiftUI
import SwiftData
import StoreKit

@Model
class Item {
    var id: UUID
    var name: String

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

@main
struct ai_projectApp: App {
    @StateObject var subscriptionManager = SubscriptionManager.shared

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                ContentView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .environmentObject(subscriptionManager)
                    .task {
                        await subscriptionManager.loadProducts()
                        await subscriptionManager.checkSubscriptionStatus()
                    }
            }
        }
    }
}
