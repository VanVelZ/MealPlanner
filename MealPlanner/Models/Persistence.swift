//
//  Persistence.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/1/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    static func saveContext(){
        do{
            try PersistenceController.shared.container.viewContext.save()
        }
        catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    init(){
        container = NSPersistentContainer(name: "MealPlanner")
        
        container.loadPersistentStores { storeDesciption, error in
            if let error = error as NSError? {
                fatalError("Unresolved Error: \(error)")
            }
        }
    }
}
