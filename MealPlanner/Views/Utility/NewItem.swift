//
//  NewItem.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/13/21.
//

import SwiftUI

struct NewItem<Content: View>: View {
    
    var destination: Content
    
    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus").padding().shadow(color: .primary, radius: 8, x: 0.5, y: 0.8)
                    Spacer()
                }
                })
    }
}

struct NewItem_Previews: PreviewProvider {
    static var previews: some View {
        NewItem(destination: MealForm(isNewMeal: true))
    }
}
