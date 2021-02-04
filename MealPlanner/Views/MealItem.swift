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
            Text(meal.name ?? "Untitled")
        }
    }
}
