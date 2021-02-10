//
//  ContentView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) private var settings: FetchedResults<UserSettings>
    var body: some View{
        NavigationView {
            GroceryListView()
                .environmentObject(settings[0])
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



