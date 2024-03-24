import SwiftUI

struct EditHabitsView: View {
    @EnvironmentObject var data: HabitsViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(data.habits) { habit in
                    NavigationLink(destination: AddHabitsView(habitToEdit: habit)) {
                        RowView(habits: habit, mode: "E",completionDate: Date())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                .onDelete(perform: data.deleteHabits)
                .onMove(perform: data.moveItem)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Modifier vos habitudes")
            .padding(12)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Ajouter", destination: AddHabitsView())
                }
            }
        }
    }
}


struct EditHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        EditHabitsView()
            .environmentObject(HabitsViewModel())
    }
}
