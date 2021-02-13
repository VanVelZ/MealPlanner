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
    var safeRecipes: [Recipe] {
        get{
        var recipeArray: [Recipe] = []
        for recipe in recipes! {
            recipeArray.append(recipe as! Recipe)
        }
        return recipeArray
    }
        set{
            recipes =  NSSet(array: newValue)
        }
    }
    
    func redoGroceryList(){
        safeGroceryList  = []
        switch self.frequencyEnum {
        case .daily:
            redoGrocery(at: 1)
        case .twiceAWeek:
            redoGrocery(at: 3.5)
        case .weekly:
            redoGrocery(at: 7)
        case .biweekly:
            redoGrocery(at: 14)
        case .monthly:
            redoGrocery(at: 30.5)
        }
        PersistenceController.saveContext()
    }
    private func addIngredientToGroceryList(groceryList: GroceryList, ingredient: Ingredient){
        var isInList: Bool = false
        groceryList.safeGroceryItems.forEach { (item) in
            if item.ingredient?.unwrappedName == ingredient.unwrappedName {
                isInList = true
            }
        }
        if(!isInList){
            let groceryItem = GroceryItem(context: PersistenceController.shared.container.viewContext)
            ingredient.addToGroceryItems(groceryItem)
            groceryItem.availability = Int64(Availibility.out.rawValue)
            groceryItem.addToInLists(groceryList)
        }
    }
    private func redoGrocery(at interval: Double){
        var groceryShopDate = Date()
        let untilNextShop: TimeInterval = 60 * 60 * 24 * interval
        var groceryList: GroceryList
        groceryList = GroceryList(context: PersistenceController.shared.container.viewContext)
        groceryList.plannedForDate = groceryShopDate
        safeGroceryList.append(groceryList)
        for meal in self.safeMeals.sorted(by: {$0.unwrappedDate < $1.unwrappedDate}) {
            if(meal.unwrappedDate < groceryShopDate.addingTimeInterval(untilNextShop)){
                for recipe in meal.safeRecipes {
                    for ingredient in recipe.safeIngredients{
                        addIngredientToGroceryList(groceryList: groceryList, ingredient: ingredient)
                    }
                }
            }
            else{
                groceryList = GroceryList(context: PersistenceController.shared.container.viewContext)
                groceryShopDate = groceryShopDate.addingTimeInterval(untilNextShop)
                groceryList.plannedForDate = groceryShopDate
                safeGroceryList.append(groceryList)
                for recipe in meal.safeRecipes {
                    for ingredient in recipe.safeIngredients{
                        addIngredientToGroceryList(groceryList: groceryList, ingredient: ingredient)
                    }
                }
            }
        }
    }
}
