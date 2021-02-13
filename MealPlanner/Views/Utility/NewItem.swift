//
//  NewItem.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/13/21.
//

import SwiftUI

struct NewItem<Content: View>: View {
    
    var destination: Content
    var itemName: String
    
    var body: some View {
            HStack{
                NavigationLink(
                    destination: destination,
                    label: {
                        Image(systemName: "plus.circle")
                    })
                Text("New \(itemName)")
            }
            .shadow(color: .gray, radius: 2)
            .font(.title)
            .padding()
    }
}

struct NewItem_Previews: PreviewProvider {
    static var previews: some View {
        NewItem(destination: MealForm(isNewMeal: true), itemName: "Meal")
    }
}
