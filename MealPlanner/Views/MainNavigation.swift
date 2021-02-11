//
//  MainNavigation.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/11/21.
//

import SwiftUI

struct MainNavigation: View {
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
            }.navigationTitle("ProFoods")
            .navigationBarItems(trailing: NavigationLink(
                                    destination: SettingsView(),
                                    label: {
                                        Text("Settings")
                                    }))
        }
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
