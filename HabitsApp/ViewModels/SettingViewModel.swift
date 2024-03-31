//
//  SettingViewModel.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 31/03/2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var selectedDate = Date()
    
    
    @Published var username: String {
           didSet {
               saveUsername(username)
           }
       }
       
       @Published var showWelcomeScreen: Bool {
           didSet {
               saveShowWelcomeScreen(showWelcomeScreen)
           }
       }
    
    @Published var isChecked: Bool{
        didSet {
            saveChecked(isChecked)
        }
    }
       
       init() {
           self.username = UserDefaults.standard.string(forKey: "username") ?? ""
           self.showWelcomeScreen = UserDefaults.standard.bool(forKey: "showWelcomeScreen")
           self.isChecked = UserDefaults.standard.object(forKey: "isChecked") as? Bool ?? true

       }
       
       private func saveUsername(_ username: String) {
           UserDefaults.standard.set(username, forKey: "username")
       }
       
       private func saveShowWelcomeScreen(_ show: Bool) {
           UserDefaults.standard.set(show, forKey: "showWelcomeScreen")
       }
    
    private func saveChecked(_ checked: Bool) {
        UserDefaults.standard.set(checked, forKey: "isChecked")
    }
}

