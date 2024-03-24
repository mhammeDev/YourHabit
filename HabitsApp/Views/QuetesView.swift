//
//  QuetesView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 24/03/2024.
//

import SwiftUI

import SwiftUI

struct QuetesView: View {
    @EnvironmentObject var habitsViewModel: HabitsViewModel
    
    var body: some View {
        VStack {
            Text("Quêtes")
                .font(.title)
                .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(1..<16) { level in
                        QuestRow(level: level)
                    }
                }
                .padding()
            }
        }
    }
}

struct QuestRow: View {
    var level: Int
    
    @EnvironmentObject var habitsViewModel: HabitsViewModel
    
    var body: some View {
        let streak = habitsViewModel.calculateStreak(from: Date())
        let completed = streak >= level * 3
        
        return HStack {
            Text("Débutant")
            Spacer()
            
            HStack{
                Text("\(streak)/\(level * 3)")
                Text(completed ? "✅" : "❌")
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding([.horizontal, .bottom])
    }
}

struct QuetesView_Previews: PreviewProvider {
    static var previews: some View {
        QuetesView()
            .environmentObject(HabitsViewModel())
    }
}
