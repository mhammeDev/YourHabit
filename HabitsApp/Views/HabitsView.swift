//
//  HabitsView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 18/03/2024.
//

import SwiftUI

struct HabitsView: View {
        
    var body: some View {
        TabView{
            HabitsListView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            HabitsListView()
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.xaxis")

                }
            HabitsListView()
                .tabItem {
                    Label("Statistics", systemImage: "figure.walk.circle.fill")

                }
            HabitsListView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")

                }
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
            .environmentObject(HabitsViewModel())
    }
}
