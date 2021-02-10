//
//  AddRecipeToMeal.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import SwiftUI


struct AddRecipeToMeal: View{
    @ObservedObject var meal: Meal
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var recipes: FetchedResults<Recipe>
    @State private var isAddingExistingRecipe: Bool = false
    var body: some View{
        HStack{
            Button(action: {isAddingExistingRecipe = true}, label: {
                Text("Add Existing Recipe")
                    .sheet(isPresented: $isAddingExistingRecipe, content: {
                        RecipeList(from: meal)
                    })
            })
            Spacer()
            Button(action: {
                let recipe = Recipe(context: viewContext)
                recipe.name = "New Recipe"
                meal.addToRecipes(recipe)
            }, label: {
                Text("Add New Recipe")
            })
        }
    }
}
