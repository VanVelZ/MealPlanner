//
//  UnitPicker.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/3/21.
//

import SwiftUI

struct UnitPicker: View {
    
    @ObservedObject var ingredient: Ingredient
    private var units: [String] = ["cup", "tbl", "tsp", "ml", "g", "lb"]
    
    var body: some View {
        Picker("\(ingredient.unit ?? "unit")", selection: $ingredient.unit){
            ForEach(units, id: \.self){ unit in
                Text(unit).tag(unit)
            }
        }.pickerStyle(MenuPickerStyle()).padding(.trailing)
    }
    init(_ ingredient: Ingredient){
        self.ingredient = ingredient
    }
}
