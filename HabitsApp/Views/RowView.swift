//
//  RowView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct RowView: View {
    
    let habits : Habits
    
    var body: some View {
        HStack{
            Image(systemName: habits.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(habits.isCompleted ? .green : .red)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(habits: Habits.testData[0])
            .previewLayout(.sizeThatFits)
        RowView(habits: Habits.testData[1])
            .previewLayout(.sizeThatFits)
        RowView(habits: Habits.testData[2])
            .previewLayout(.sizeThatFits)
        RowView(habits: Habits.testData[3])
            .previewLayout(.sizeThatFits)
    }
}
