//
//  GroceryList.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/9/21.
//

import SwiftUI

struct GroceryListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var groceryLists: FetchedResults<GroceryList>
    
    var body: some View {
            List {
                ForEach(groceryLists){ list in
                    NavigationLink(
                        destination: GroceryView(),
                        label: {
                            Text("Grocery shop for \(list.plannedForDate ?? Date())")
                        })
                }
            }.onDisappear{
                PersistenceController.saveContext()
            }
            .navigationTitle("Grocery List")
    }
}

struct GroceryList_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
