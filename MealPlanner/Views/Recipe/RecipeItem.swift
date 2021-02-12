//
//  RecipeItem.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import SwiftUI

struct RecipeItem: View {
    
    @ObservedObject var recipe: Recipe
    @State private var editingRecipe: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    var meal: Meal?
    
    
    var body: some View{
        HStack {
            if meal == nil{
                NavigationLink(
                    destination: EditRecipeForm(recipe: recipe),
                    label: {
                        Text("\(recipe.unwrappedName)")
                    })
            }
            else{
                Text(recipe.name ?? defaultRecipeName)
                    .onTapGesture {
                        meal?.addToRecipes(recipe)
                    }
            }
        }.onDisappear{
            PersistenceController.saveContext()
        }
    }
    
    private let addRecipeToMealImage = "calendar.badge.plus"
    private let defaultRecipeName = "Untitled Recipe"
}
struct RecipeItem_Previews: PreviewProvider {
    static var previews: some View {
        RecipeItem(recipe: Recipe(context: PersistenceController.shared.container.viewContext))
    }
}
