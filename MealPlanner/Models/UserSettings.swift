//
//  Settings.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import Foundation

extension UserSettings {
    var frequencyEnum: Frequency{
        get{
        Frequency(rawValue: Int(groceryFrequency )) ?? .daily
        }
        set{
            groceryFrequency =  Int64(newValue.rawValue)
        }
    }
}
