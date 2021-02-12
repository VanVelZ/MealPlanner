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
        HStack {
            TextField("name", text: $name)
                .font(.headline)
            DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
        }
    }
}
