//
//  EditIngredientForm.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import SwiftUI

struct EditIngredientForm: View{
    @ObservedObject var ingredient: Ingredient
    @State private var isAdding = true
    @EnvironmentObject private var recipe: Recipe
    private var units: [String] = ["cup", "tbl", "tsp", "ml", "g"]
    
    init(ingredient: Ingredient){
        self.ingredient = ingredient
    }
    
    
    var body: some View{
            HStack{
                if ingredient.forRecipe == nil {
                    Button(action: {
                        ingredient.forRecipe = recipe
                    }, label: {
                        HStack{
                            Spacer()
                            Text("+").font(.largeTitle).frame(alignment: .center)
                            Spacer()
                        }
                    })
                }
                else {
                    TextField("ingredient amount", value: $ingredient.amount, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    Picker(selection: $ingredient.unit, label: Text(ingredient.unit ?? "Unit")){
                        ForEach(0..<units.count){
                            Text(units[$0])
                        }
                    }
                    TextField("ingredient name", text: $ingredient.unwrappedName)
                }
            }
    }
}

