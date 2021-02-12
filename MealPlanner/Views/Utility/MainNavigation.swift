//
//  MainNavigation.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/11/21.
//

import SwiftUI

struct MainNavigation: View {
    
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    
    var body: some View {
        NavigationView{
            List {
                NavigationLink(
                    destination: MealList(),
                    label: {
                        Text("Meals")
                    })
                NavigationLink(
                    destination: GroceryListView(),
                    label: {
                        Text("Groceries")
                    })
                NavigationLink("Recipes", destination: RecipeList())
            }
            .navigationTitle("ProFoods")
            .navigationBarItems(trailing: NavigationLink(
                                    destination: SettingsView(),
                                    label: {
                                        Text("Settings")
                                    }))
        }
        .environmentObject(users[0])
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
