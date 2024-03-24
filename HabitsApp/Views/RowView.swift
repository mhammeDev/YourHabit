//
//  RowView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct RowView: View {
    
    var habits : Habits
    var mode : Character
    @EnvironmentObject var data: HabitsViewModel
    var completionDate: Date

    
    var body: some View {
        HStack{
            if(mode == "V"){
                Rectangle()
                    .cornerRadius(15)
                    .frame(width: 350, height: 80)
                    .foregroundColor(Color(.systemGray5))
                    .onTapGesture {
                        if(mode == "V"){
                            data.updateItem(habit: habits, date: completionDate)
                        }
                    }
                    .overlay(
                        HStack{
                            if(mode == "V"){
                                Image(systemName: data.isDateInHabits(habit: habits, date: completionDate) ? "checkmark.circle" : "circle")
                                    .foregroundColor(data.isDateInHabits(habit: habits, date: completionDate) ? .green : .red)
                                Spacer()
                            }
                            Text(habits.title)
                        }.font(.title)
                            .padding(10)
                        
                    )
            }
            else if (mode == "E"){
                Text(habits.title)
                    .padding(.vertical,8)
            }
            else if(mode == "S") {
                    Rectangle()
                        .cornerRadius(15)
                        .frame(width: 350, height: 80)
                        .foregroundColor(Color(data.isDateInHabits(habit: habits, date: completionDate) ? .green : .red))
                        .overlay(
                            HStack{
                                Text(habits.title)
                            }.font(.title)
                                .padding(10)
                            
                        )
                
            }

        }
        .font(.title2)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(habits: Habits.testData[0], mode: "V", completionDate :Date())
            .environmentObject(HabitsViewModel())
    }
}
