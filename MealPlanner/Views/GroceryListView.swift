//
//  GroceryList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/9/21.
//

import SwiftUI

struct GroceryListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var groceryLists: FetchedResults<GroceryList>
    
    var body: some View {
            List {
                ForEach(groceryLists){ recipe in
                    //TODO: add the grocery item view
                }
                .onDelete { (index) in
                    deleteRecipe(offsets: index)
                }
            }.onDisappear{
                PersistenceController.saveContext()
            }
            .navigationTitle("Grocery List")
            .navigationBarItems(trailing: Button(action: {
                addRecipe()
            }, label: {
                Text(newRecipeText)
            }))
    }
    private func deleteRecipe(offsets: IndexSet){
        withAnimation{
            offsets.map{groceryLists[$0]}.forEach(viewContext.delete)
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

struct GroceryList_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
