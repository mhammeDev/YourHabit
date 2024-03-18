//
//  HabitsListView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct HabitsListView: View {
    
    @EnvironmentObject var data: HabitsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            Text(Date(), style: .date)
                .font(.largeTitle)
                .bold()
                .padding([.top, .horizontal])
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(data.habits) { habit in
                        RowView(habits: habit)
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
