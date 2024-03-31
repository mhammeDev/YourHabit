//
//  QuetesView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 24/03/2024.
//

import SwiftUI

struct QuetesView: View {
    @EnvironmentObject var habitsViewModel: HabitsViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel

    
    var body: some View {
        ScrollView {
            Text("Quêtes")
                .font(.title)
                .bold()
                .padding()
            
            VStack(spacing: 15) {
                ForEach(QuestLevel.allCases, id: \.self) { level in
                    QuestRow(level: level)
                }            }
            .padding(.top)
        }
    }
}

enum QuestLevel: Int, CaseIterable {
    case debutant, intermediaire, avance, expert, maitre, maitreSupreme, boss
    
    var title: String {
        switch self {
        case .debutant:
            return "Débutant"
        case .intermediaire:
            return "Intermédiaire"
        case .avance:
            return "Avancé"
        case .expert:
            return "Expert"
        case .maitre:
            return "Maître"
        case .maitreSupreme:
            return "Maître Suprême"
        case .boss:
            return "Boss"
        }
    }

    var threshold: Int {
        switch self {
        case .debutant:
            return 3
        case .intermediaire:
            return 6
        case .avance:
            return 9
        case .expert:
            return 12
        case .maitre:
            return 15
        case .maitreSupreme:
            return 18
        case .boss:
            return 21
        }
    }
}

struct QuestRow: View {
    var level: QuestLevel
    @EnvironmentObject var habitsViewModel: HabitsViewModel
    @EnvironmentObject var settingsViewModel: SettingsViewModel

    
    var body: some View {
        let streak = habitsViewModel.calculateStreak(from:settingsViewModel.selectedDate )
        let completed = streak >= level.threshold
        let displayStreak = min(streak, level.threshold)
        
        HStack {
            Text(level.title)
                .font(.title2)
            Spacer()
            
            Text("\(displayStreak)/\(level.threshold)")
                .font(.title2)
                .padding(.horizontal)
            
                    
            if completed {
                Image(systemName: "trophy.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "lock.fill")
                    .resizable()
                    .frame(width: 40, height: 50)
                    .foregroundColor(Color(.darkGray))
            }
            
        }
        .padding()
        .frame(height: 100)
        .background(completed ? Color(.systemGray6) : Color(.systemGray3))
        .cornerRadius(15)
        .padding([.horizontal, .bottom])
    }
}

struct QuetesView_Previews: PreviewProvider {
    static var previews: some View {
        QuetesView()
            .environmentObject(HabitsViewModel())
            .environmentObject(SettingsViewModel())
    }
}

