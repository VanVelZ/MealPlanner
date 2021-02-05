//
//  MealPlannerWidget.swift
//  MealPlannerWidget
//
//  Created by Zach Vandervelden on 2/5/21.
//

import WidgetKit
import SwiftUI
import Intents

struct RecipeEntry: TimelineEntry{
    var date: Date
    let meals: [Meal]
}


struct Provider: TimelineProvider{
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Meal.plannedForDate, ascending: true)]) private var meals: FetchedResults<Meal>
    
    func placeholder(in context: Context) -> RecipeEntry {
        let meal: Meal = Meal()
        meal.name = "Breakfast"
        meal.plannedForDate = Date()
        return RecipeEntry(date: Date(), meals: [meal])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RecipeEntry) -> Void) {
        var mealArray: [Meal] = []
        meals.forEach{mealArray.append($0)}
        let entry = RecipeEntry(date: Date(), meals: mealArray)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<RecipeEntry>) -> Void) {
            var mealArray: [Meal] = []
            meals.forEach{mealArray.append($0)}
            let entry = RecipeEntry(date: Date(), meals: mealArray)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
    }
}

struct WidgetEntryView: View{
    let entry: Provider.Entry
    
    var body: some View{
        ForEach(entry.meals){
            Text($0.unwrappedName)
        }
    }
}

@main
struct MealWidget: Widget{
    private let kind = "MealWidget"
    
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: kind, provider: Provider()){entry in
            WidgetEntryView(entry: entry)
        }
    }
}
