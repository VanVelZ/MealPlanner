//
//  Recipe.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import Foundation

extension Recipe{
    var unwrappedName: String {
        get{
            self.name!
        }
        set{
            name = newValue
        }
    }
    var safeIngredients: [Ingredient] {
        get{
        var ingredientArray: [Ingredient] = []
        for ingredient in ingredients! {
            ingredientArray.append(ingredient as! Ingredient)
        }
        return ingredientArray
    }
    }
}
