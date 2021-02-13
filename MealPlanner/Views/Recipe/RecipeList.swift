//
//  RecipeList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import SwiftUI

struct RecipeList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var user: User
    
    var meal: Meal?
    
    init(){
        
    }
    init(from meal: Meal){
        self.meal = meal
    }
    
    
    var body: some View {
            List {
                ForEach(user.safeRecipes){ recipe in
                    if meal != nil {
                        RecipeItem(recipe: recipe, meal: meal)
                    } else {
                        RecipeItem(recipe: recipe)
                    }
                }
                .onDelete { (index) in
                    deleteRecipe(offsets: index)
                }
            }.onDisappear{
                PersistenceController.saveContext()
            }
        .navigationTitle("Recipes")
    }
    private func deleteRecipe(offsets: IndexSet){
        withAnimation{
            offsets.map{user.safeRecipes[$0]}.forEach(viewContext.delete)
        }
    }
    private var newRecipeText = "New Recipe"
}
