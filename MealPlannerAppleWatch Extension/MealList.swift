//
//  MealList.swift
//  MealPlannerAppleWatch Extension
//
//  Created by Zach Vandervelden on 2/5/21.
//

import SwiftUI

struct MealList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Meal.plannedForDate, ascending: true)]) private var meals: FetchedResults<Meal>
    
    
    var body: some View {
            List {
                //NavigationLink("All Recipes", destination: RecipeList())
                ForEach(meals){ meal in
                    Text(meal.unwrappedName)
                }
                .onDelete { (index) in
                    deleteMeal(offsets: index)
                }
                .onDisappear{
                    PersistenceController.saveContext()
                    saveMealsForWidget()
                }
                .onAppear{ saveMealsForWidget()}
            }
            .navigationTitle("Meals")
    }
    private func saveMealsForWidget(){
        var mealNames: [String] = []
        meals.forEach{mealNames.append($0.unwrappedName)}
        UserDefaults.standard.set(mealNames, forKey: "mealNamesArray")
    }
    private func deleteMeal(offsets: IndexSet){
        withAnimation{
            offsets.map{meals[$0]}.forEach(viewContext.delete)
        }
    }
    private func addMeal(){
        withAnimation{
            let newMeal = Meal(context: viewContext)
            newMeal.name = newMealText
            newMeal.plannedForDate = Date()
        }
    }
    private var newMealText = "New Meal"
}
