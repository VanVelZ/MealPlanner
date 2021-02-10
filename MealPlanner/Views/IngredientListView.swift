//
//  IngredientListView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import SwiftUI

struct IngredientListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var ingredients: [Ingredient]
    
    var body: some View {
        List{
            ForEach(ingredients){ ingredient in
                EditIngredientForm(ingredient: ingredient)
            }
            .onDelete { (indices) in
                indices.map{ingredients[$0]}.forEach(viewContext.delete)
            }
            EditIngredientForm(ingredient: Ingredient(context: viewContext))
        }
    }
}
