//
//  MealList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/4/21.
//

import SwiftUI

struct MealList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    
    
    private func addMeal() -> Meal{
        withAnimation{
            let newMeal = Meal(context: viewContext)
            newMeal.name = "New Meal"
            newMeal.plannedForDate = Date()
            user.addToMeals(newMeal)
            return newMeal
        }
    }
    
    var body: some View {
            List {
                    NavigationLink("All Recipes", destination: RecipeList())
                    ForEach(user.safeMeals){ meal in
                        MealItem(meal: meal)
                    }
                    .onDelete { (index) in
                        deleteMeal(offsets: index)
                    }
                    .onDisappear{
                        PersistenceController.saveContext()
                    }
                }
                .navigationTitle("Meals")
                .navigationBarItems(trailing: NavigationLink(
                                        destination: MealForm(meal: addMeal()),
                                        label: {
                                            Text("\(newMealText)")
                                        }))
    }
    private func deleteMeal(offsets: IndexSet){
        withAnimation{
            offsets.map{user.safeMeals[$0]}.forEach(viewContext.delete)
        }
    }
    private var newMealText = "New Meal"
}
