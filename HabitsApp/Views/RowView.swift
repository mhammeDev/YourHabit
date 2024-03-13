//
//  RowView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct RowView: View {
    
    var habits : Habits
    @EnvironmentObject var data: HabitsViewModel

    
    var body: some View {
        HStack{
            Rectangle()
                .cornerRadius(15)
                .frame(width: 350, height: 60)
                .foregroundColor(.gray)
                .onTapGesture {
                    data.updateItem(habit: habits)
                }
                .overlay(
                    HStack{
                        Image(systemName: habits.isCompleted ? "checkmark.circle" : "circle")
                            .foregroundColor(habits.isCompleted ? .green : .red)
                        Spacer()
                        Text(habits.title)
                    }.font(.title2)
                        .padding(10)
                    
                )

        }
        .font(.title2)
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(habits: Habits.testData[0])
            .environmentObject(HabitsViewModel())
    }
}
