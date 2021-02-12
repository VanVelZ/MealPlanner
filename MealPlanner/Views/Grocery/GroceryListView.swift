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
        List(user.safeGroceryList.sorted(by: {$0.unwrappedDate < $1.unwrappedDate})){ list in
            NavigationLink(
                destination: GroceryView(groceries: list),
                label: {
                    Text("Grocery shop for \(list.unwrappedDate.dayOfTheWeek)")
                })
        }.onDisappear{
            PersistenceController.saveContext()
        }
        .navigationTitle("Groceries")
    }
}

struct GroceryList_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
