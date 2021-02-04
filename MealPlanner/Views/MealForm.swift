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
            Section{
                VStack {
                    TextField("name", text: $meal.unwrappedName).textFieldStyle(RoundedBorderTextFieldStyle()).font(.title)
                    DatePicker("", selection: $meal.unwrappedDate, in: Date()..., displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
                }
        }
            Section(header: AddRecipeToMeal(meal: meal)) {
                ForEach(meal.safeRecipes){ recipe in
                    RecipeItem(recipe: recipe)
                }.onDelete(perform: { indexSet in
                    deleteRecipe(offsets: indexSet)
                })
            }
        }.onDisappear{
            PersistenceController.saveContext()
        }
        .navigationTitle("\(meal.unwrappedName) on \(meal.dayOfTheWeek)")
    }
    struct AddRecipeToMeal: View{
        @ObservedObject var meal: Meal
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(sortDescriptors: []) private var recipes: FetchedResults<Recipe>
        @State private var isAddingExistingRecipe: Bool = false
        var body: some View{
            HStack{
                Button(action: {isAddingExistingRecipe = true}, label: {
                    Text("Add Existing Recipe")
                        .popover(isPresented: $isAddingExistingRecipe, content: {
                            List(recipes){recipe in
                                Text(recipe.unwrappedName)
                            }
                        })
                })
                Spacer()
                Button(action: {
                    let recipe = Recipe(context: viewContext)
                    recipe.name = "New Recipe"
                    meal.addToRecipes(recipe)
                }, label: {
                    Text("Add New Recipe")
                })
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
