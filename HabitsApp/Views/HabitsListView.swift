//
//  HabitsListView.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import SwiftUI

struct HabitsListView: View {
    
    @EnvironmentObject var data : HabitsViewModel
    
    var body: some View {
        NavigationView {
            List{
                ForEach(data.habits){ habits in
                    RowView(habits: habits)
                }
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
