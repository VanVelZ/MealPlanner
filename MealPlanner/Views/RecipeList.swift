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
    
    
    var body: some View {
            List {
                ForEach(recipes){ recipe in
                    RecipeItem(recipe: recipe)
                }
                .onDelete { (index) in
                    deleteRecipe(offsets: index)
                }
            }
            .navigationTitle("Recipes")
            .navigationBarItems(trailing: Button(action: {
                addRecipe()
            }, label: {
                Text("+").font(.largeTitle)
            }))
    }
    private func deleteRecipe(offsets: IndexSet){
        withAnimation{
            offsets.map{recipes[$0]}.forEach(viewContext.delete)
            PersistenceController.saveContext()
        }
    }
    private func addRecipe(){
        withAnimation{
            let newRecipe = Recipe(context: viewContext)
            newRecipe.name = "New Recipe"
            PersistenceController.saveContext()
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}
