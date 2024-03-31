//
//  HabitsView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 18/03/2024.
//

import SwiftUI

struct HabitsView: View {
        
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State private var showWelcome = true

    
    var body: some View {
        
        if showWelcome && settingsViewModel.showWelcomeScreen {
            WelcomeView( onContinue: {
                self.showWelcome = false
            })
        }else{
            
        TabView{
            HabitsListView()
                .tabItem {
                    Label("Accueil", systemImage: "house.fill")
                }
            StatistiqueView()
                .tabItem {
                    Label("Statistiques", systemImage: "chart.bar.xaxis")
                    
                }
            QuetesView()
                .tabItem {
                    Label("Quêtes", systemImage: "trophy")
                    
                }
            EditHabitsView()
                .tabItem {
                    Label("Modifier", systemImage: "square.and.pencil")
                    
                }
            SettingsView()
                .tabItem {
                    Label("Réglages", systemImage: "gearshape.fill")
                    
                }
        }.onAppear{
            self.showWelcome = false
        }
    }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
            .environmentObject(HabitsViewModel())
            .environmentObject(SettingsViewModel())
            .environmentObject(Notification.shared)
    }
}
