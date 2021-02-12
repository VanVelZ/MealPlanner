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
        VStack{
            List {
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
            HStack{
                Spacer()
            ZStack{
                Circle().foregroundColor(.blue).frame(maxWidth: 100, maxHeight: 100)
                NavigationLink(
                    destination: MealForm(isNewMeal: true),
                    label: {
                        Image(systemName: "plus").font(.largeTitle).foregroundColor(.black)
                    }).padding()
            }.padding()
            }
        }
        .navigationTitle("Meals")
    }
    private func deleteMeal(offsets: IndexSet){
        withAnimation{
            offsets.map{user.safeMeals[$0]}.forEach(viewContext.delete)
        }
    }
    private var newMealText = "New Meal"
}
