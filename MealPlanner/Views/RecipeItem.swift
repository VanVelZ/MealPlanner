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
    var body: some View{
        HStack {
            Text(recipe.name ?? "Untitled")
                .onTapGesture {
                    addingRecipe = true
                }
                .sheet(isPresented: $addingRecipe, content: {
                    EditRecipeForm(recipe: recipe)
                }).onDisappear{
                    saveContext()
            }
            Spacer()
            Image(systemName: "calendar.badge.plus")
        }
    }
    private func saveContext(){
        do{
            try viewContext.save()
        }
        catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
}
struct RecipeItem_Previews: PreviewProvider {
    static var previews: some View {
        RecipeItem(recipe: Recipe(context: PersistenceController.shared.container.viewContext))
    }
}
