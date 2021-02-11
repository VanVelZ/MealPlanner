//
//  ContentView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    
    var body: some View{
            MainNavigation()
        .environmentObject(users[0])
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



