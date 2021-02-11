//
//  MealForm.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/3/21.
//

import SwiftUI

struct MealForm: View {
    
    @ObservedObject var meal: Meal
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    
    var body: some View {
        Form{
            Section{
                NameAndDate(name: $meal.unwrappedName, date: $meal.unwrappedDate)
            }
            Section(header: AddRecipeToMeal(meal: meal)) {
                ForEach(meal.safeRecipes){ recipe in
                    RecipeItem(recipe: recipe)
                }.onDelete(perform: { indexSet in
                    deleteRecipe(offsets: indexSet)
                })
            }
        }.onDisappear{
            PersistenceController.saveContext()
            user.redoGroceryList()
        }
    }
    private func deleteRecipe(offsets: IndexSet){
        withAnimation{
            offsets.map{meal.safeRecipes[$0]}.forEach(meal.removeFromRecipes)
        }
    }
}

struct MealForm_Previews: PreviewProvider {
    static var previews: some View {
        MealForm(meal: Meal(context: PersistenceController.shared.container.viewContext))
    }
}
