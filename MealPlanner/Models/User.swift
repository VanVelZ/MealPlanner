//
//  Settings.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import Foundation

extension User {
    var frequencyEnum: Frequency{
        get{
        Frequency(rawValue: Int(groceryFrequency )) ?? .daily
        }
        set{
            groceryFrequency =  Int64(newValue.rawValue)
            redoGroceryList()
        }
    }
    var safeGroceryList: [GroceryList] {
        get{
        var groceryArray: [GroceryList] = []
        for groceryList in groceryLists! {
            groceryArray.append(groceryList as! GroceryList)
        }
        return groceryArray
    }
        set{
            groceryLists =  NSSet(array: newValue)
        }
    }
    var safeMeals: [Meal] {
        get{
        var meals: [Meal] = []
        for meal in groceryLists! {
            meals.append(meal as! Meal)
        }
        return meals
    }
        set{
            groceryLists =  NSSet(array: newValue)
        }
    }
    
    private func redoGroceryList(){
        safeGroceryList  = []
        switch self.frequencyEnum {
        case .daily:
            redoDailyGrocery()
        case .twiceAWeek:
            redoTwiceAWeekGrocery()
        case .weekly:
            redoWeeklyGrocery()
        case .biweekly:
            redoBiWeeklyGrocery()
        case .monthly:
            redoMonthlyGrocery()
        }
    }
    private func redoDailyGrocery(){
        
    }
    private func redoTwiceAWeekGrocery(){
        
    }
    private func redoWeeklyGrocery(){
        
    }
    private func redoBiWeeklyGrocery(){
        
    }
    private func redoMonthlyGrocery(){
        
    }
}
