//
//  Habits.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import Foundation

/*enum Colors : String, CaseIterable{
    case vert = "vert"
}*/

struct Habits : Identifiable{
    var id = UUID()
    var title : String
    var completionDates: [Date]
    //var colors : Colors
    
    static var testData = [
        Habits(title: "Faire 10 pompes", completionDates: []),
        Habits(title: "Boire de l'eau", completionDates: []),
        Habits(title: "Courir 30 minutes", completionDates: []),
        Habits(title: "Faire 3000 pas", completionDates: []),


 
    ]
}
