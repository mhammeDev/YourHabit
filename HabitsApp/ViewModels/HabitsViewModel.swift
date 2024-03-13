//
//  HabitsViewModel.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import Foundation

class HabitsViewModel: ObservableObject{
    
    @Published var habits : [Habits]=[]
    
    init(){
        getHabits()
    }
    
    func getHabits(){
        habits.append(contentsOf: Habits.testData)
    }
    
    func updateItem(habit: Habits){
        for(index, td) in habits.enumerated(){
            if td.id == habit.id {
                habits[index].isCompleted.toggle()
                habits[index].title = habit.title
            }
            
        }
    }
    
}
