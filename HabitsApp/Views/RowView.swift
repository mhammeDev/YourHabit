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
    
    var percentage: Int? = nil
    


    
    var body: some View {
        HStack{
            if(mode == "V"){
                Rectangle()
                    .cornerRadius(15)
                    .frame(width: 350, height: 80)
                    .foregroundColor(Color(.systemGray6))

                    .onTapGesture {
                        if(mode == "V"){
                            data.updateItem(habit: habits, date: completionDate)
                        }
                    }
                    .overlay(
                        HStack{
                            if(mode == "V"){
                                Image(systemName: data.isDateInHabits(habit: habits, date: completionDate) ? "checkmark.circle.fill" : "multiply.circle.fill")
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
                        .foregroundColor(Color(data.isDateInHabits(habit: habits, date: completionDate) ? .systemGreen : .systemRed))
                        .overlay(
                            HStack{
                                Text(habits.title)
                            }.font(.title)
                                .padding(10)
                            
                        )
                
            }
            else if mode == "X" {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .cornerRadius(15)
                        .frame(width: 350, height: 80)
                        .foregroundColor(Color(.blue))

                    Rectangle()
                        .cornerRadius(15)
                        .frame(width: CGFloat(percentage ?? 0) / 100.0 * 350, height: 80)
                        .foregroundColor(Color(.white).opacity(0.5))
                        .animation(.linear, value: percentage)

                    HStack {
                        Text(habits.title)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(percentage ?? 0)%")
                            .foregroundColor(.white)
                    }.padding(20)
                    .font(.title)
                } .padding(.horizontal)
            }


        }
        .font(.title2)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(habits: Habits.testData[0], mode: "V", completionDate :Date(), percentage: 40)
            .environmentObject(HabitsViewModel())
    }
}
