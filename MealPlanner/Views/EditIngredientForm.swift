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
                    TextField("Ingredient amount", value: $ingredient.amount, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(maxWidth: 40)
                    Picker(selection: $ingredient.unit, label: Text(ingredient.unit ?? "Unit")){
                        ForEach(0..<units.count){
                            Text(units[$0])
                        }
                    }.pickerStyle(MenuPickerStyle()).padding(.trailing)
                    
                    TextField("Ingredient name", text: $ingredient.unwrappedName)
                }
            }
    }
}

