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
    private var units: [String] = ["cup", "tbl", "tsp", "ml", "g", "lb"]
    
    init(ingredient: Ingredient){
        self.ingredient = ingredient
        print(ingredient.unit ?? "no unit set")
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
                    DecimalField("#", value: $ingredient.optionalAmount, formatter: NumberFormatter())
                        .frame(maxWidth: 40)
                    Picker("\(ingredient.unit ?? "unit")", selection: $ingredient.unit){
                        ForEach(units, id: \.self){ unit in
                            Text(unit).tag(unit)
                        }
                    }.pickerStyle(MenuPickerStyle()).padding(.trailing)
                    TextField("Ingredient name", text: $ingredient.unwrappedName)
                }
            }.onDisappear{
                PersistenceController.saveContext()
            }
    }
}

