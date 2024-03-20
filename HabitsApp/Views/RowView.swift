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

    
    var body: some View {
        HStack{
            if(mode == "V"){
                Rectangle()
                    .cornerRadius(15)
                    .frame(width: 350, height: 80)
                    .foregroundColor(Color(.systemGray5))
                    .onTapGesture {
                        if(mode == "V"){
                            data.updateItem(habit: habits)
                        }
                    }
                    .overlay(
                        HStack{
                            if(mode == "V"){
                                Image(systemName: habits.isCompleted ? "checkmark.circle" : "circle")
                                    .foregroundColor(habits.isCompleted ? .green : .red)
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

        }
        .font(.title2)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(habits: Habits.testData[0], mode: "E")
            .environmentObject(HabitsViewModel())
    }
}
