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
        TabView {
            NavigationView {
                MealList()
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Meals")
            }
            NavigationView {
                RecipeList()
            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Recipes")
            }
            NavigationView {
                GroceryListView()
            }
            .tabItem {
                Image(systemName: "3.circle")
                Text("Groceries")
            }
        }
        .edgesIgnoringSafeArea(.top)
        .environmentObject(users[0])
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
