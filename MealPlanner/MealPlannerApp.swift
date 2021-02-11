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
    @FetchRequest(sortDescriptors: []) private var user: FetchedResults<User>
    
    init(){
        if user.count == 0{
            let user = User(context: persistenceContainer.container.viewContext)
            user.frequencyEnum =  .weekly
            PersistenceController.saveContext()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainNavigation()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
