//
//  StatistiqueView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 24/03/2024.
//

import SwiftUI

struct StatistiqueView: View {
    @EnvironmentObject var data: HabitsViewModel
    
    @State private var selectedStatType = StatType.daily
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false
    
    @State private var selectedWeekStartDate = Date()
    
    private let startDateOfRange = Date()
    private let endDateOfRange = Calendar.current.date(byAdding: .weekOfYear, value: 4, to: Date())!
    
    var body: some View {
        VStack {
            Text("Statistiques")
                .font(.title)
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
                        Text(selectedDate, style: .date)
                            .font(.title3)
                            .bold()
                        
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
                                    selection: $selectedDate,
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
                    .padding([.top, .horizontal])
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 18) {
                            ForEach(data.habits) { habit in
                                RowView(habits: habit, mode: "S", completionDate: selectedDate)
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    Text("Statistiques hebdomadaires")
                        .font(.headline)
                        .padding(.top)
                    
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
                                .font(.title3) // Réduit la taille du texte
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
                        .padding()
                        
                        ForEach(data.habits) { habit in
                            let percentage = data.calculateWeeklyPercentage(for: habit, startDate: selectedWeekStartDate)
                            Text("\(habit.title): \(percentage)%")
                        }
                    }
                    .padding()
                }
                Spacer() // Aligne les éléments au centre de l'écran
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
    }
}


