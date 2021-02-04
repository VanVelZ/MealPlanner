//
//  RecipeItem.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import SwiftUI

struct RecipeItem: View {
    
    @ObservedObject var recipe: Recipe
    @State private var addingRecipe: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var addingToMeal: Bool = false
    
    
    var body: some View{
        HStack {
            Text(recipe.name ?? defaultRecipeName)
                .onTapGesture {
                    addingRecipe = true
                }
                .sheet(isPresented: $addingRecipe, content: {
                    EditRecipeForm(recipe: recipe)
                })
            Spacer()
            Image(systemName: addRecipeToMealImage)
                .popover(isPresented: $addingToMeal, content: {
                    MealForm()
                })
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
