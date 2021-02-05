//
//  MealList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/4/21.
//

import SwiftUI

struct MealList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Meal.plannedForDate, ascending: true)]) private var meals: FetchedResults<Meal>
    
    @AppStorage("mealNames", store: UserDefaults(suiteName: "group.com.prozach.MealPlanner"))
    var mealNamesData: Data = Data()
    
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
                .onAppear{ saveMealsForWidget()}
            }
            .navigationTitle("Meals")
            .navigationBarItems(trailing: Button(action: {
                addMeal()
            }, label: {
                Text(newMealText)
            }))
    }
    private func saveMealsForWidget(){
        var mealNames: [String] = []
        meals.forEach{mealNames.append($0.unwrappedName)}
        guard let namesData = try? JSONEncoder().encode(mealNames) else {return}
        print(mealNames)
        mealNamesData = namesData
    }
    private func deleteMeal(offsets: IndexSet){
        withAnimation{
            offsets.map{meals[$0]}.forEach(viewContext.delete)
        }
    }
    private func addMeal(){
        withAnimation{
            let newMeal = Meal(context: viewContext)
            newMeal.name = newMealText
            newMeal.plannedForDate = Date()
        }
    }
    private var newMealText = "New Meal"
}

struct MealList_Previews: PreviewProvider {
    static var previews: some View {
        MealList()
    }
}
