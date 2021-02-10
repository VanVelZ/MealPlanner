//
//  GroceryList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import Foundation

extension GroceryList {
    
    var safeIngredients: [Ingredient] {
        get{
        var ingredientArray: [Ingredient] = []
        for ingredient in ingredients! {
            ingredientArray.append(ingredient as! Ingredient)
        }
        return ingredientArray
    }
        set{
            ingredients =  NSSet(array: newValue)
        }
    }
}
