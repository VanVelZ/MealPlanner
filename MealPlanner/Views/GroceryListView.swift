//
//  GroceryList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/9/21.
//

import SwiftUI

struct GroceryListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    
    var body: some View {
            List {
                ForEach(user.safeGroceryList){ list in
                    NavigationLink(
                        destination: GroceryView(groceries: list),
                        label: {
                            Text("Grocery shop for \(list.plannedForDate?.dayOfTheWeek ?? Date().dayOfTheWeek)")
                        })
                }
            }.onDisappear{
                PersistenceController.saveContext()
            }
            .navigationBarItems(trailing: NavigationLink(
                                    destination: SettingsView(),
                                    label: {
                                        Text("Settings")
                                    }))
            .navigationTitle("Grocery List")
    }
}

struct GroceryList_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
