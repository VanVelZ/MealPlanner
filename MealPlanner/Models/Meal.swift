//
//  Meal.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/4/21.
//

import Foundation

extension Meal{
    var unwrappedName: String {
        get{
            name ?? ""
        }
        set {
            name = newValue
        }
    }
    var unwrappedDate: Date {
        get{
            plannedForDate ?? Date()
        }
        set {
            plannedForDate = newValue
        }
    }
    var safeRecipes: [Recipe] {
        get{
        var recipeArray: [Recipe] = []
        for recipe in recipes! {
            recipeArray.append(recipe as! Recipe)
        }
        return recipeArray
    }
    }
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        return dateFormatter.string(from: unwrappedDate) // 12/15/16
            
    }
}
