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
        HStack {
            NavigationLink("\(meal.name ?? "Untitled") on \(meal.dayOfTheWeek)", destination: MealForm(meal: meal))
        }
    }
}
