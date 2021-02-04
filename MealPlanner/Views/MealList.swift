//
//  MealList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/4/21.
//

import SwiftUI

struct MealList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var meals: FetchedResults<Meal>
    
    var body: some View {
            List {
                NavigationLink("All Recipes", destination: RecipeList())
                ForEach(meals){ meal in
                    MealItem(meal: meal)
                }
                .onDelete { (index) in
                    deleteMeal(offsets: index)
                }
                .onDisappear{
                    PersistenceController.saveContext()
                }
            }
            .navigationTitle("Meals")
            .navigationBarItems(trailing: Button(action: {
                addMeal()
            }, label: {
                Text("+").font(.largeTitle)
            }))
    }
    private func deleteMeal(offsets: IndexSet){
        withAnimation{
            offsets.map{meals[$0]}.forEach(viewContext.delete)
        }
    }
    private func addMeal(){
        withAnimation{
            let newMeal = Meal(context: viewContext)
            newMeal.name = "New Meal"
            newMeal.plannedForDate = Date()
        }
    }
}

struct MealList_Previews: PreviewProvider {
    static var previews: some View {
        MealList()
    }
}
