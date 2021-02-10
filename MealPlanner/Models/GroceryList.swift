//
//  GroceryList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import Foundation

extension GroceryList {
    
    var safeGroceryItems: [GroceryItem] {
        get{
        var groceryItemsArray: [GroceryItem] = []
        for groceryItem in groceryItems! {
            groceryItemsArray.append(groceryItem as! GroceryItem)
        }
        return groceryItemsArray
    }
        set{
            groceryItems =  NSSet(array: newValue)
        }
    }
}
