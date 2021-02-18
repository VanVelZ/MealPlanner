//
//  Pantry.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/18/21.
//

import Foundation

extension Pantry{
    var safeGroceryItems: [GroceryItem]{
        get{
            var groceryItemsArray: [GroceryItem] = []
            for groceryItem in groceryItems! {
                groceryItemsArray.append(groceryItem as! GroceryItem)
            }
            return groceryItemsArray
        }
        set{
            groceryItems = NSSet(array: newValue)
        }
    }
}
