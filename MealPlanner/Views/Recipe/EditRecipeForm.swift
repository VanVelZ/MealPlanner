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
    @EnvironmentObject var user: User
    private var isAdding: Bool = false
    
    init(){
        isAdding = true
        recipe = Recipe(context: PersistenceController.shared.container.viewContext)
    }
    init(recipe: Recipe){
        self.recipe = recipe
    }
    private func deleteIngredient(ingredient: Ingredient){
        withAnimation{
            recipe.removeFromIngredients(ingredient)
        }
    }
    private func addRecipe(){
        withAnimation{
            recipe.user = user
            print("addded to user")
        }
    }
    private func onClose(){
        if isAdding{ addRecipe()}
        if recipe.name != nil {
            PersistenceController.saveContext()
        }
        else{
            viewContext.delete(recipe)
        }
    }
    var body: some View{
        Form{
            Section{
                TextField("Recipe Name", text: $recipe.unwrappedName).onAppear{
                    if recipe.name == "New Recipe"{
                        recipe.name = ""
                    }
                }
            }
            Section(header: Text("Ingredients").font(.subheadline)){
                IngredientListView(ingredients: $recipe.safeIngredients)
            }
            .onDisappear{ onClose()}
            .environmentObject(recipe)
        }
    }
}


struct EditRecipeForm_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeForm()
    }
}
