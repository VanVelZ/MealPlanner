//
//  SettingsView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    
    
    
    var body: some View {
        Form{
            Picker("Trip Schedule", selection: $user.frequencyEnum) {
                List{
                Text("Daily").tag(Frequency.daily)
                Text("Twice a Week").tag(Frequency.twiceAWeek)
                Text("Weekly").tag(Frequency.weekly)
                Text("BiWeekly").tag(Frequency.biweekly)
                Text("Monthly").tag(Frequency.monthly)
                }.onDisappear{
                    PersistenceController.saveContext()
                }
            }
        }.onDisappear{
            PersistenceController.saveContext()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
