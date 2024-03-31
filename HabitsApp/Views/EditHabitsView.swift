import SwiftUI

struct EditHabitsView: View {
    @EnvironmentObject var data: HabitsViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Modifier vos habitudes")
                    .font(.title)
                    .bold()
                    .padding()

                List {
                    ForEach(data.habits) { habit in
                        NavigationLink(destination: AddHabitsView(habitToEdit: habit)) {
                            RowView(habits: habit, mode: "E", completionDate: Date())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .onDelete(perform: data.deleteHabits)
                    .onMove(perform: data.moveItem)
                }
                .listStyle(PlainListStyle())

                HStack {
                    EditButton()
                    Spacer()
                    NavigationLink("Ajouter", destination: AddHabitsView())
                }
                .padding(30)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}


struct EditHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        EditHabitsView()
            .environmentObject(HabitsViewModel())
    }
}
