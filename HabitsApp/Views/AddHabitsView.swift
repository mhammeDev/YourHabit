//
//  AddHabitsView.swift
//  HabitsApp
//
//  Created by mechroubi m'hammed on 20/03/2024.
//

import SwiftUI

struct AddHabitsView: View {
    @State var habitsTitle: String = ""
    @EnvironmentObject var data: HabitsViewModel
    @Environment(\.presentationMode) var presentationMode
    var habitToEdit: Habits?

    var body: some View {
        VStack (spacing: 16){            
            TextField(habitToEdit == nil ? "Ajouter votre habitude" : "Modifier votre habitude", text: $habitsTitle)
                .padding(.horizontal)
                .frame(height:55)
                .background(Color(.systemGray4))
                .cornerRadius(10)
            
            Button {
                if let habit = habitToEdit {
                    data.updateItem(habit: habit, title: habitsTitle)
                } else {
                    data.addHabit(title: habitsTitle)
                }
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text(habitToEdit == nil ? "Sauvegarder" : "Modifier")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(14)
        .navigationTitle(habitToEdit == nil ? "Ajouter une habitude" : "Modifier une habitude")
        .onAppear {
            if let habit = habitToEdit {
                habitsTitle = habit.title
            }
        }
    }
}

struct AddHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            AddHabitsView()
            
        }
    }
}
