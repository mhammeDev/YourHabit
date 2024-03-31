//
//  Habits.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import Foundation
import SwiftUI


/*enum Colors : String, CaseIterable{
    case vert = "vert"
}*/

struct Habits : Identifiable{
    var id = UUID()
    var title : String
    var completionDates: [Date]
    var color : Color
    
    static var testData = [
        Habits(title: "Faire 10 pompes", completionDates: [], color: Color(.systemBlue)),
        Habits(title: "Boire de l'eau", completionDates: [], color: Color(.systemOrange)),
        Habits(title: "Courir 30 minutes", completionDates: [], color: Color(.systemPurple)),
        Habits(title: "Faire 3000 pas", completionDates: [], color: Color.pink)
    ]
}
