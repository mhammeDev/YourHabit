//
//  Notification.swift
//  HabitsApp
//
//  Created by mechroubi m'hammed on 27/03/2024.
//

import SwiftUI
import UserNotifications

class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    
    @Published var authorizationStatus: UNAuthorizationStatus?
    
    override init() {
        super.init()
        getNotificationAuthorizationStatus()
    }
    
    func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Autorisation acceptée")
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation pour les notifications push : \(error.localizedDescription)")
            }
            self.getNotificationAuthorizationStatus()
            completion(granted)
        }
    }
    
    private func getNotificationAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func registerForRemoteNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func unregisterForRemoteNotifications() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
}


