//
//  GroceryItemView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import SwiftUI

struct GroceryItemView: View {
    @ObservedObject var groceryItem: GroceryItem
    
    var body: some View {
        Text("\(groceryItem.ingredient?.name ?? "")")
    }
}

