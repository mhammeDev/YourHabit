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
    
    func addHabits(title: String){
        let newHabits = Habits(title: title, isCompleted: false)
        habits.append(newHabits)
    }
    
    func deleteHabits(indexSet: IndexSet) {
        habits.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to:Int){
        habits.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(habit: Habits, title: String){
        for(index, td) in habits.enumerated(){
            if td.id == habit.id {
                habits[index].isCompleted.toggle()
                habits[index].title = title
            }
            
        }
    }
        
    
    func updateItem(habit: Habits){
        for(index, td) in habits.enumerated(){
            if td.id == habit.id {
                habits[index].isCompleted.toggle()
            }
            
        }
    }
    
}
