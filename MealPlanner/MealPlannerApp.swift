//
//  MealPlannerApp.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/1/21.
//

import SwiftUI

@main
struct MealPlannerApp: App {
    
    let persistenceContainer = PersistenceController.shared
    @FetchRequest(sortDescriptors: []) private var settings: FetchedResults<UserSettings>
    
    init(){
        if settings.count == 0{
            let settings = UserSettings(context: persistenceContainer.container.viewContext)
            settings.frequencyEnum =  .weekly
            try? persistenceContainer.container.viewContext.save()
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
