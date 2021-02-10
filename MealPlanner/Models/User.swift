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
            for meal in self.meals! {
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
        PersistenceController.saveContext()
    }
    private func redoDailyGrocery(){
        let viewContext = PersistenceController.shared.container.viewContext
        var groceryShopDate = Date()
        let untilNextShop: TimeInterval = 60 * 60 * 24 * 1
        var groceryList: GroceryList
        groceryList = GroceryList(context: viewContext)
        groceryList.plannedForDate = groceryShopDate
        safeGroceryList.append(groceryList)
        for meal in self.safeMeals.sorted(by: {$0.unwrappedDate < $1.unwrappedDate}) {
            if(meal.unwrappedDate < groceryShopDate.addingTimeInterval(untilNextShop)){
                for recipe in meal.safeRecipes {
                    for ingredient in recipe.safeIngredients{
                        let groceryItem = GroceryItem(context: viewContext)
                        ingredient.addToGroceryItems(groceryItem)
                        groceryItem.availability = Int64(Availibility.out.rawValue)
                        groceryItem.addToInLists(groceryList)
                        PersistenceController.saveContext()
                    }
                }
            }
            else{
                groceryList = GroceryList(context: viewContext)
                groceryShopDate = groceryShopDate.addingTimeInterval(untilNextShop)
                safeGroceryList.append(groceryList)
                for recipe in meal.safeRecipes {
                    for ingredient in recipe.safeIngredients{
                        let groceryItem = GroceryItem(context: viewContext)
                        ingredient.addToGroceryItems(groceryItem)
                        groceryItem.availability = Int64(Availibility.out.rawValue)
                        groceryItem.addToInLists(groceryList)
                        PersistenceController.saveContext()
                    }
                }
            }
        }
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
