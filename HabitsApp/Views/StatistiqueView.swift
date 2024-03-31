//
//  StatistiqueView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 24/03/2024.
//

import SwiftUI

struct StatistiqueView: View {
    @EnvironmentObject var data: HabitsViewModel
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
        
    @State private var selectedStatType = StatType.daily
    @State private var showingDatePicker = false
    
    @State private var selectedWeekStartDate = Date()
    
    private let startDateOfRange = Date()
    private let endDateOfRange = Calendar.current.date(byAdding: .weekOfYear, value: 4, to: Date())!
    
    var body: some View {
        VStack {
            Text("Statistiques")
                .font(.title)
                .bold()
                .padding()
            
            Picker("Sélectionner le type de statistique", selection: $selectedStatType) {
                Text("Quotidienne").tag(StatType.daily)
                Text("Hebdomadaire").tag(StatType.weekly)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            VStack {
                if selectedStatType == .daily {
                    HStack {
                        Text(    settingsViewModel.selectedDate, style: .date)
                            .font(.title3)
                        
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
                                    selection: $settingsViewModel.selectedDate
,
                                    in: Date()...endDateOfRange,
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
                    .padding(25)
                                        
                    ScrollView {
                        VStack(alignment: .leading, spacing: 18) {
                            ForEach(data.habits) { habit in
                                RowView(habits: habit, mode: "S", completionDate:     settingsViewModel.selectedDate)
                            }
                        }
                        .padding(.horizontal)
                    }

                } else {
                    VStack {
                        HStack {
                            Button(action: {
                                let newStartDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedWeekStartDate)!
                                if newStartDate >= startDateOfRange {
                                    selectedWeekStartDate = newStartDate
                                }
                            }) {
                                Image(systemName: "chevron.left")
                            }
                            .padding(.trailing)
                            
                            Spacer()
                            
                            Text("\(selectedWeekStartDate, style: .date) - \(Calendar.current.date(byAdding: .day, value: 6, to: selectedWeekStartDate)!, style: .date)")
                                .font(.title3)
                                .multilineTextAlignment(.center) // Centre le texte
                            
                            Spacer()
                            
                            Button(action: {
                                let newStartDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedWeekStartDate)!
                                if newStartDate <= endDateOfRange {
                                    selectedWeekStartDate = newStartDate
                                }
                            }) {
                                Image(systemName: "chevron.right")
                            }
                            .padding(.leading)
                        }
                        .padding(25)
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 18) {
                                ForEach(data.habits) { habit in
                                    RowView(habits: habit, mode: "X", completionDate:     settingsViewModel.selectedDate,percentage: data.calculateWeeklyPercentage(for: habit, startDate: selectedWeekStartDate))
                                }
                            }
                        }                        .padding(.horizontal)
                        
                    }
                }
                Spacer()
            }
        }
    }
}




enum StatType {
    case daily
    case weekly
}


struct StatistiqueView_Previews: PreviewProvider {
    static var previews: some View {
        StatistiqueView()
            .environmentObject(HabitsViewModel())
            .environmentObject(SettingsViewModel())
    }
}


