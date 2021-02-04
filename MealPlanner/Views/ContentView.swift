//
//  ContentView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View{
        NavigationView {
            MealList()
            RecipeList()
            Text("Checking things")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



