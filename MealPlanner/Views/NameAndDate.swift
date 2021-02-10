//
//  NameAndDate.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import SwiftUI

struct NameAndDate: View {
    
    @Binding var name: String
    @Binding var date: Date
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title).padding()
            DatePicker("", selection: $date, in: Date()..., displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}
