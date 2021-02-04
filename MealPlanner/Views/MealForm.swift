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
    
    var body: some View {
        Form{
            Section(header: Text(meal.unwrappedName)){
                HStack{
            TextField("name", text: $meal.unwrappedName)
            DatePicker("", selection: $meal.unwrappedDate, in: Date()...)
                }
        }
            Section {
                ForEach(meal.safeRecipes){ recipe in
                    RecipeItem(recipe: recipe)
                }.onDelete(perform: { indexSet in
                    deleteRecipe(offsets: indexSet)
                })
                HStack{
                    Button(action: {}, label: {
                        Text("Add Existing Recipe")
                    })
                    Spacer()
                    Button(action: {
                        let recipe = Recipe(context: viewContext)
                        recipe.name = "New Recipe"
                        meal.addToRecipes(recipe)
                    }, label: {
                        Text("Add New Recipe")
                    })
                }.onDisappear{
                    PersistenceController.saveContext()
                }
            }
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
