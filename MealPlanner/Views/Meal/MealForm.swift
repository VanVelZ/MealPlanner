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
    @EnvironmentObject var user: User
    
    private var isNewMeal:Bool = false
    
    init(isNewMeal: Bool = true){
        print("is making a meal")
        self.isNewMeal = isNewMeal
        meal = Meal(context: PersistenceController.shared.container.viewContext)
    }
    init(meal: Meal){
        self.meal = meal
    }
    
    var body: some View {
        Form{
            NameAndDate(name: $meal.unwrappedName, date: $meal.unwrappedDate)
            Section(header: AddRecipeToMeal(meal: meal)) {
                ForEach(meal.safeRecipes){ recipe in
                    RecipeItem(recipe: recipe)
                }.onDelete(perform: { indexSet in
                    deleteRecipe(offsets: indexSet)
                })
            }
        }
        .navigationTitle("\(meal.name ?? "Untitled") on \(meal.unwrappedDate.dayOfTheWeek)")
        .onDisappear{ onClose()}
    }
    
    private func onClose(){
        if isNewMeal {addMeal()}
        if(meal.name != nil){
            PersistenceController.saveContext()
            user.redoGroceryList()
        }
        else{viewContext.delete(meal)}
    }
    
    private func addMeal(){
        withAnimation{
            user.addToMeals(meal)
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
