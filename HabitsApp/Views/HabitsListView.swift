//
//  HabitsListView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct HabitsListView: View {
    
    @EnvironmentObject var data: HabitsViewModel
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            HStack {
                Text(selectedDate, style: .date)
                    .font(.largeTitle)
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
            .padding([.top, .horizontal])
            
            Text("Le message d'accueil sera ici, avec utilisateur")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(data.habits) { habit in
                        RowView(habits: habit, mode: "V")
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HabitsListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView()
            .environmentObject(HabitsViewModel())
    }
}
