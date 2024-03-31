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
    
    
    @State private var selectedColor = Color(UIColor.systemBlue)
    
    let systemColors: [UIColor] = [.systemBlue, .systemOrange, .systemIndigo, .systemPurple, .systemYellow, .systemBrown]

       var body: some View {
           VStack(spacing: 16) {
               TextField(habitToEdit == nil ? "Ajouter votre habitude" : "Modifier votre habitude", text: $habitsTitle)
                   .padding(.horizontal)
                   .frame(height: 55)
                   .background(Color(.systemGray4))
                   .cornerRadius(10)
               
               ColorPickerView(systemColors: systemColors, selectedColor: $selectedColor)
                   .padding(.vertical)
            
            Button {
                if let habit = habitToEdit {
                    data.updateItem(habit: habit, title: habitsTitle, color: selectedColor)
                } else {
                    data.addHabit(title: habitsTitle, color: selectedColor)
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
        .padding(15)
        .navigationTitle(habitToEdit == nil ? "Ajouter une habitude" : "Modifier une habitude")
        .onAppear {
            if let habit = habitToEdit {
                habitsTitle = habit.title
                selectedColor = habit.color
            }
        }
       }
}

struct ColorPickerView: View {
    let systemColors: [UIColor]
    @Binding var selectedColor: Color
    

    var body: some View {
        HStack {
            ForEach(systemColors, id: \.self) { uiColor in
                let color = Color(uiColor)
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 3)
                    )
                    .onTapGesture {
                        selectedColor = color
                    }
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
