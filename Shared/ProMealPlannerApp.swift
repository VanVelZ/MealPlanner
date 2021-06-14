//
//  ProMealPlannerApp.swift
//  Shared
//
//  Created by Zach Vandervelden on 6/14/21.
//

import SwiftUI

@main
struct ProMealPlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
