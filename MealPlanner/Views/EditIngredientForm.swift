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
                    TextField("unit", text: $ingredient.unwrappedUnit)
                    TextField(namePlaceHolder, text: $ingredient.unwrappedName)
                }
            }.onDisappear{
                PersistenceController.saveContext()
            }
    }
    private var namePlaceHolder = "Ingredient name"
}



