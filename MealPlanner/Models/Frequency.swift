//
//  Frequency.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import Foundation

enum Frequency: Int, Codable, Hashable{
    case daily = 1
    case twiceAWeek = 3
    case weekly = 7
    case biweekly = 14
    case monthly = 30
}
