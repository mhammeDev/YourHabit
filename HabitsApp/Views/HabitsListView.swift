//
//  HabitsListView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct HabitsListView: View {
    
    @EnvironmentObject var data: HabitsViewModel
    @State private var showingDatePicker = false
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel


    var body: some View {
        VStack(alignment: .center) {
            Text("Accueil")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            HStack {
                Text(settingsViewModel.selectedDate, style: .date)
                    .font(.title2)
                Spacer()
                
                Button(action: {
                    showingDatePicker = true
                }) {
                    Image(systemName: "calendar")
                        .font(.title)
                }
                .sheet(isPresented: $showingDatePicker) {
                    VStack {
                        DatePicker(
                            "Sélectionner la date",
                            selection: $settingsViewModel.selectedDate,
                            in: Date()...Date().addingTimeInterval(30 * 24 * 60 * 60),
                            displayedComponents: .date
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        
                        Button("Confirmer") {
                            showingDatePicker = false
                        }
                        .padding()
                    }
                }
            }
            .padding([.top, .horizontal,.bottom])
            
            if settingsViewModel.isChecked {
                motivationalMessage
            }
            
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(data.habits) { habit in
                        RowView(habits: habit, mode: "V",completionDate: settingsViewModel.selectedDate)
                    }
                }
                .padding(.horizontal)
            }.padding(10)
        }
    }
    
    private var motivationalMessage: some View {
        let totalHabits = data.getHabitsSize()
        let streak = data.calculateDayPercentage(current: settingsViewModel.selectedDate)
        let message: String

        if streak == totalHabits {
            message = "Parfait \(settingsViewModel.username) ! 👌🏼"
        } else if streak > totalHabits / 2 {
            message = "Super travail \(settingsViewModel.username), continue comme ça ! ✌🏽"
        } else {
            message = "Bouge toi \(settingsViewModel.username), il est temps d'agir ! 👎🏼"
        }

        return HStack {
            Spacer()
            Text(message)
                .font(.title2)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding([.horizontal,.top])
    }
}

struct HabitsListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView()
            .environmentObject(HabitsViewModel())
            .environmentObject(SettingsViewModel())

    }
}
