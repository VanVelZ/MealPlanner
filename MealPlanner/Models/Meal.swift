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
}