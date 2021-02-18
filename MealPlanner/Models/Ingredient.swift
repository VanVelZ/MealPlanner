//
//  Ingredient.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/2/21.
//

import Foundation

extension Ingredient{
    var unwrappedName: String { get{ self.name ?? ""} set{ name = newValue}}
    var unwrappedUnit: String { get{ self.unit ?? ""} set { unit = newValue}}
    var optionalAmount: Double? { get { amount } set { amount = newValue ?? 0.0}}
}
