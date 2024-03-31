//
//  HabitsAppApp.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

@main
struct HabitsAppApp: App {
    var body: some Scene {
        WindowGroup {
            HabitsView()
                .environmentObject(HabitsViewModel())
                .environmentObject(Notification.shared)
                .environmentObject(SettingsViewModel())

        }
    }
}
