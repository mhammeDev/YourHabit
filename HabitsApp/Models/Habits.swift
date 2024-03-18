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
    var isCompleted : Bool
    //var colors : Colors
    
    static var testData = [
        Habits(title: "Faire 10 pompes", isCompleted: true),
        Habits(title: "Boire de l'eau", isCompleted: false),
        Habits(title: "Courrir 30 minutes", isCompleted: false),
        Habits(title: "Faire 3000 pas", isCompleted: true),
        Habits(title: "Courrir 30 minutes", isCompleted: false),
        Habits(title: "Courrir 30 minutes", isCompleted: false),
        Habits(title: "Courrir 30 minutes", isCompleted: false),
    ]
}
