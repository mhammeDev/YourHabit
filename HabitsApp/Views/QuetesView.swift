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
    
    var icons: [String] {
        switch self {
        case .debutant:
            return ["star.fill", "star.fill", "star.fill", "star.fill"]
        case .intermediaire:
            return ["leaf.fill", "leaf.fill", "leaf.fill", "leaf.fill"]
        case .avance:
            return ["heart.fill", "heart.fill", "heart.fill", "heart.fill"]
        case .expert:
            return ["moon.fill", "moon.fill", "moon.fill", "moon.fill"]
        case .maitre:
            return ["sun.max.fill", "sun.max.fill", "sun.max.fill", "sun.max.fill"]
        case .maitreSupreme:
            return ["flame.fill", "flame.fill", "flame.fill", "flame.fill"]
        case .boss:
            return ["crown.fill", "crown.fill", "crown.fill", "crown.fill"]
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
        
        ZStack {
            patternBackground(completed: completed)
                .frame(height: 100)
                .cornerRadius(15)
            
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
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(.darkGray))
                }
            }
            .padding()
        }
        .frame(height: 100)
        .background(completed ? Color(.systemGray6) : Color(.systemGray3))
        .cornerRadius(15)
        .padding([.horizontal, .bottom])
    }
    
    @ViewBuilder
    private func patternBackground(completed: Bool) -> some View {
        if(completed){
            GeometryReader { geometry in
                let positions = [
                    CGPoint(x: geometry.size.width * 0.15, y: geometry.size.height * 0.35),
                    CGPoint(x: geometry.size.width * 0.6, y: geometry.size.height * 0.2),
                    CGPoint(x: geometry.size.width * 0.4, y: geometry.size.height * 0.8),
                    CGPoint(x: geometry.size.width * 0.85, y: geometry.size.height * 0.8)
                ]
            
                ForEach(0..<4, id: \.self) { index in
                    Image(systemName: level.icons[index])
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.yellow.opacity(0.2))
                        .frame(width: 60, height: 60)
                        .position(positions[index])
                }        }
    }

    }
}

struct QuetesView_Previews: PreviewProvider {
    static var previews: some View {
        QuetesView()
            .environmentObject(HabitsViewModel())
            .environmentObject(SettingsViewModel())
    }
}

