//
//  RecipeList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import SwiftUI

struct RecipeList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) private var recipes: FetchedResults<Recipe>
    
    var meal: Meal?
    
    init(){
        
    }
    init(from meal: Meal){
        self.meal = meal
    }
    
    
    var body: some View {
            List {
                    ForEach(recipes){ recipe in
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
                .navigationBarItems(trailing: Button(action: {
                    addRecipe()
                }, label: {
                    Text(newRecipeText)
            }))
    }
    private func deleteRecipe(offsets: IndexSet){
        withAnimation{
            offsets.map{recipes[$0]}.forEach(viewContext.delete)
        }
    }
    private func addRecipe(){
        withAnimation{
            let newRecipe = Recipe(context: viewContext)
            newRecipe.name = newRecipeText
        }
    }
    private var newRecipeText = "New Recipe"
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}
