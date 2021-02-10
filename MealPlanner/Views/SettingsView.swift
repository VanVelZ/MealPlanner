//
//  SettingsView.swift
//  MealPlanner
//
//  Created by Zach Vandervelden on 2/10/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var userSetting: UserSettings
    
    
    
    var body: some View {
        Form{
            Picker("Trip Schedule", selection: $userSetting.frequencyEnum) {
                Text("Daily").tag(Frequency.daily)
                Text("Twice a Week").tag(Frequency.twiceAWeek)
                Text("Weekly").tag(Frequency.weekly)
                Text("BiWeekly").tag(Frequency.biweekly)
                Text("Monthly").tag(Frequency.monthly)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
