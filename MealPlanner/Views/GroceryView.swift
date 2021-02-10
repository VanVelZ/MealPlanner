//
//  GroceryItem.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/9/21.
//

import SwiftUI

struct GroceryView: View {
    
    @ObservedObject var groceries: GroceryList
    
    var body: some View {
        IngredientListView(ingredients: $groceries.safeIngredients)
    }
}
