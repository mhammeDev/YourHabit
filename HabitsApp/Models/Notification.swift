//
//  Notification.swift
//  HabitsApp
//
//  Created by mechroubi m'hammed on 27/03/2024.
//

import SwiftUI
import UserNotifications

class Notification: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    static let shared = Notification()
    @Published var authorizationStatus: UNAuthorizationStatus?

    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        requestAuthorization { granted in
            print("Notification permission granted: \(granted)")
        }    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("Notifications autorisées")
                } else if let error = error {
                    print("Erreur de demande d'autorisation: \(error.localizedDescription)")
                }
                self.getNotificationAuthorizationStatus()
                completion(granted)
            }
        }
    }
    
    private func getNotificationAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func disableNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleNotification(date: Date, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
}


