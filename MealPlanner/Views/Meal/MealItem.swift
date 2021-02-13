//
//  MealItem.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/4/21.
//

import SwiftUI

struct MealItem: View {
    @ObservedObject var meal: Meal
    
    var body: some View {
        NavigationLink(
            destination: MealForm(meal: meal),
            label: {
                Text("\(meal.name ?? "Untitled") on \(meal.unwrappedDate.dayOfTheWeek)")
            })
    }
}
