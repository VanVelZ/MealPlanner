//
//  MealList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/4/21.
//

import SwiftUI

struct MealList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    
    
    
    var body: some View {
            List {
                Section(header: NewItem(destination: MealForm())){
                ForEach(user.safeMeals){ meal in
                    MealItem(meal: meal)
                }
                .onDelete { (index) in
                    deleteMeal(offsets: index)
                }
                .onDisappear{
                    PersistenceController.saveContext()
                }
                }
            }
        .navigationTitle(Text("Meals"))
    }
    private func deleteMeal(offsets: IndexSet){
        withAnimation{
            offsets.map{user.safeMeals[$0]}.forEach(viewContext.delete)
        }
    }
    private var newMealText = "New Meal"
}
