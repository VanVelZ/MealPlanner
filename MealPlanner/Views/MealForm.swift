//
//  MealForm.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/3/21.
//

import SwiftUI

struct MealForm: View {
    
    @ObservedObject var meal: Meal
    
    var body: some View {
        Form{
        TextField("name", text: $meal.unwrappedName)
            DatePicker("date", selection: $meal.unwrappedDate, in: Date()...).datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}

struct MealForm_Previews: PreviewProvider {
    static var previews: some View {
        MealForm(meal: Meal(context: PersistenceController.shared.container.viewContext))
    }
}
