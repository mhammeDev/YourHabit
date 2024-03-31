//
//  HabitsViewModel.swift
//  HabitsApp
//
//  Created by majourel ambre on 06/03/2024.
//

import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habits] = []
    
    init() {
        getHabits()
    }
    
    func getHabits() {
        habits.append(contentsOf: Habits.testData)
    }
    
    func addHabit(title: String) {
        let newHabit = Habits(title: title, completionDates: [])
        habits.append(newHabit)
    }
    
    func deleteHabits(indexSet: IndexSet) {
        habits.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        habits.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(habit: Habits, title: String) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].title = title
        }
    }
    
    func isDateInHabits(habit: Habits, date: Date) -> Bool {
        for completionDate in habit.completionDates {
            if Calendar.current.isDate(completionDate, inSameDayAs: date) {
                return true
            }
        }
        return false
    }
    
    func updateItem(habit: Habits, date: Date) {
        print(calculateStreak(from: Date()))
        for (index, td) in habits.enumerated() {
            if td.id == habit.id {
                if habits[index].completionDates.contains(date) {
                    if let indexToRemove = habits[index].completionDates.firstIndex(of: date) {
                        habits[index].completionDates.remove(at: indexToRemove)
                    }
                } else {
                    habits[index].completionDates.append(date)
                }
            }
        }
    }
    
    func calculateWeeklyPercentage(for habit: Habits, startDate: Date) -> Int {
        let endDate = Calendar.current.date(byAdding: .day, value: 6, to: startDate)!
        let startDateInclusive = Calendar.current.date(byAdding: .day, value: -1, to: startDate)!
        let completionCountInWeek = habit.completionDates.filter { date in
            startDateInclusive...endDate ~= date
        }.count
        let totalDaysInWeek = Double(Calendar.current.dateComponents([.day], from: startDateInclusive, to: endDate).day ?? 1)
        let percentage = Double(completionCountInWeek) * 100 / totalDaysInWeek
        return Int(percentage.rounded())
    }
    
    func calculateStreak(from startDate: Date) -> Int {
        var streak = 0
        var currentDate = startDate
        print("ici")
        print(streak)
        print(startDate)
        var allHabitsCompleted = true
        
        while allHabitsCompleted {
            for habit in habits {
                if !isDateInHabits(habit: habit, date: currentDate) {
                    allHabitsCompleted = false
                    break
                }
            }
            
            if allHabitsCompleted {
                streak += 1
                currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            }
        }
        /*
        
        while allHabitsCompleted {
            for habit in habits {
                if !isDateInHabits(habit: habit, date: currentDate) {
                    allHabitsCompleted = false
                    break
                }
            }
            
            if allHabitsCompleted {
                streak += 1
                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            }
        }
         */
        
        return streak
    }
    
    func getIncompleteHabits(for date: Date) -> [Habits] {
        return habits.filter { !isDateInHabits(habit: $0, date: date) }
    }



}

