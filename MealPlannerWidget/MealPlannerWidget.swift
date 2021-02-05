//
//  MealPlannerWidget.swift
//  MealPlannerWidget
//
//  Created by Zach Vandervelden on 2/5/21.
//

import WidgetKit
import SwiftUI
import Intents

struct MealEntry: TimelineEntry{
    var date: Date
    let meals: [String]
}


struct Provider: TimelineProvider{
    
    func placeholder(in context: Context) -> MealEntry {
        return MealEntry(date: Date(), meals: ["Breakfast", "Lunch", "Dinner"])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> Void) {
        let meals = UserDefaults.standard.object(forKey: "mealNamesArray") as? [String] ?? [String]()
        let entry = MealEntry(date: Date(), meals: meals)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MealEntry>) -> Void) {
        let meals = UserDefaults.standard.object(forKey: "mealNamesArray") as? [String] ?? [String]()
        let entry = MealEntry(date: Date(), meals: meals)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntryView: View{
    let entry: Provider.Entry
    
    var body: some View{
        ForEach(entry.meals, id: \.self){
            Text($0)
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
