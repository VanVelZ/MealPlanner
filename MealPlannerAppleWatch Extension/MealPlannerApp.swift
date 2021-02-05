//
//  MealPlannerApp.swift
//  MealPlannerAppleWatch Extension
//
//  Created by Zach Vandervelden on 2/5/21.
//

import SwiftUI
import CoreData

@main
struct MealPlannerApp: App {
    let persistenceContainer = PersistenceController.shared
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MealPlanWatchView()
                    .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
