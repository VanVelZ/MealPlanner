//
//  EditRecipeForm.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import SwiftUI

struct EditRecipeForm: View{
    @ObservedObject var recipe: Recipe
    @Environment(\.managedObjectContext) private var viewContext
    
    init(){
        recipe = Recipe()
    }
    init(recipe: Recipe){
        self.recipe = recipe
    }
    private func deleteIngredient(ingredient: Ingredient){
        withAnimation{
            recipe.removeFromIngredients(ingredient)
            PersistenceController.saveContext()
        }
    }
    var body: some View{
        NavigationView{
        Form{
            Section{
                TextField("Recipe Name", text: $recipe.unwrappedName).onAppear{
                    if recipe.name == "New Recipe"{
                        recipe.name = ""
                    }
                }
                .onDisappear{
                    if recipe.name == "" {
                        recipe.name = "New Recipe"
                    }
                }
            }
            Section(header: Text("Ingredients").font(.subheadline)){
                List{
                ForEach(recipe.safeIngredients){ ingredient in
                    EditIngredientForm(ingredient: ingredient)
                }
                .onDelete { (indices) in
                    indices.map{recipe.safeIngredients[$0]}.forEach(viewContext.delete)
                }
                EditIngredientForm(ingredient: Ingredient(context: viewContext))
            }
            }
            .environmentObject(recipe)
        }
    }
    }
}


struct EditRecipeForm_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeForm()
    }
}
