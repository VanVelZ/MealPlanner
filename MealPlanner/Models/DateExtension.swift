//
//  DateExtension.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/9/21.
//

import Foundation


extension Date{
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        return dateFormatter.string(from: self) // 12/15/16
            
    }
    
}
