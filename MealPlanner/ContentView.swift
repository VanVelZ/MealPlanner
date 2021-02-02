//
//  ContentView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) private var recipes: FetchedResults<Recipe>
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes){ recipe in
                    RecipeItem(recipe: recipe)
                }.onDelete { (index) in
                    deleteRecipe(offsets: index)
                }
            }
            .navigationTitle("Recipes")
            .navigationBarItems(trailing: Button("+"){
                addRecipe()
            }).font(.title)
        }
    }
    private func deleteRecipe(offsets: IndexSet){
        withAnimation{
            offsets.map{recipes[$0]}.forEach(viewContext.delete)
            saveContext()
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
    private func addRecipe(){
        withAnimation{
            let newRecipe = Recipe(context: viewContext)
            newRecipe.name = "New Recipe"
            saveContext()
        }
    }
}
struct EditRecipeForm: View{
    @ObservedObject var recipe: Recipe
    @Environment(\.managedObjectContext) private var viewContext
    
    init(){
        recipe = Recipe()
    }
    init(recipe: Recipe){
        self.recipe = recipe
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
    var body: some View{
        Form{
            Section(header: Text("New Recipe").font(.subheadline)){
                TextField("Recipe Name", text: $recipe.unwrappedName)
            }
            Section(header: Text("Ingredients").font(.subheadline)){
                ForEach(recipe.safeIngredients){ ingredient in
                    EditIngredientForm(ingredient: ingredient)
                }
                EditIngredientForm(ingredient: Ingredient(context: viewContext))
            }.environmentObject(recipe)
        }
    }
}

struct EditIngredientForm: View{
    @ObservedObject var ingredient: Ingredient
    @State private var isAdding = true
    @EnvironmentObject private var recipe: Recipe
    
    var body: some View{
        HStack{
            TextField("ingredient amount", value: $ingredient.amount, formatter: NumberFormatter())
            TextField("units", text: .constant("units"))
            TextField("ingredient name", text: $ingredient.unwrappedName)
            if ingredient.forRecipe == nil {
                Button(action: {
                    ingredient.forRecipe = recipe
                }, label: {
                    Text("+").font(.largeTitle)
                })
            }
        }
    }
}
struct RecipeItem: View {
    @ObservedObject var recipe: Recipe
    @State private var addingRecipe: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View{
        Text(recipe.name ?? "Untitled")
            .onTapGesture {
                addingRecipe = true
            }
            .sheet(isPresented: $addingRecipe, content: {
                EditRecipeForm(recipe: recipe)
            }).onDisappear{
                saveContext()
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Recipe{
    var unwrappedName: String {
        get{
            self.name!
        }
        set{
            name = newValue
        }
    }
    var safeIngredients: [Ingredient] {
        get{
        var ingredientArray: [Ingredient] = []
        for ingredient in ingredients! {
            ingredientArray.append(ingredient as! Ingredient)
        }
        return ingredientArray
    }
    }
}
extension Ingredient{
    var unwrappedName: String {
        get{
            self.name ?? "UnNamedIngredient"
        }
        set{
            name = newValue
        }
    }
}
