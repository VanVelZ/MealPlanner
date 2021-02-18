//
//  Recipe.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import Foundation

extension Recipe{
    var unwrappedName: String { get{ self.name ?? ""} set{ name = newValue} }
    var unwrappedDateAdded: Date { get{ dateAdded ?? Date()} set { dateAdded = newValue}}
    var unwrappedInstructions: String { get{ instructions ?? ""} set { instructions = newValue}}
    
    var safeIngredients: [Ingredient] {
        get{
        var ingredientArray: [Ingredient] = []
        for ingredient in ingredients! {
            ingredientArray.append(ingredient as! Ingredient)
        }
        return ingredientArray
    }
        set{ ingredients =  NSSet(array: newValue)}
    }
}

