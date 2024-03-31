import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    @State private var pushNotificationEnabled = false
    @EnvironmentObject var notificationManager: Notification
    
    @State private var notificationTimes: [Date] = []
    @State private var newNotificationTime = Date()
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    @EnvironmentObject var data: HabitsViewModel
    
    var body: some View {
        ScrollView{
            Text("Réglages")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            VStack(alignment: .leading, spacing: 30) {

        
            TextField("Entrez votre nom d'utilisateur", text: $settingsViewModel.username)
                .padding()
                .frame(height: 55)
                .background(Color(.systemGray4))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Toggle("Page de démarrage", isOn: $settingsViewModel.showWelcomeScreen)
                .padding(.horizontal)
            
            Toggle("Message Accueil", isOn: $settingsViewModel.isChecked)
                .padding(.horizontal)
            
            Toggle("Notification push", isOn: $pushNotificationEnabled)
                .padding(.horizontal)
                .onChange(of: pushNotificationEnabled, perform: { value in
                    if value {
                        notificationManager.requestAuthorization { granted in
                            if granted {
                                print("Notifications activées")
                            } else {
                                pushNotificationEnabled = false
                            }
                        }
                    } else {
                        notificationManager.disableNotifications()
                    }
                })
            
            if pushNotificationEnabled {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Créneaux horaires pour les notifications:")
                        .padding(.leading)
                    ForEach(notificationTimes, id: \.self) { time in
                        HStack{
                            Text(dateFormatter.string(from: time))
                                .padding(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                if let index = notificationTimes.firstIndex(of: time) {
                                    notificationTimes.remove(at: index)
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                                    .padding(10)
                            }
                        }

                    }
                    HStack {
                        DatePicker("", selection: $newNotificationTime, displayedComponents: .hourAndMinute)
                            .padding(.horizontal)
                        Button("Ajouter") {
                            notificationTimes.append(newNotificationTime)
                            scheduleNotification(for: newNotificationTime)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            
            HStack {
                Text(isDarkModeEnabled ? "Activer le mode lumineux" : "Activer le mode sombre")
                
                Spacer()
                
                Button(action: {
                    isDarkModeEnabled.toggle()
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
                }) {
                    Image(systemName: isDarkModeEnabled ? "sun.max.fill" : "moon.fill")
                        .foregroundColor(isDarkModeEnabled ? .yellow : .gray) // Change la couleur en fonction du mode
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.top)
        .onAppear{
            pushNotificationEnabled = notificationManager.authorizationStatus == .authorized
        }
        }
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    private func scheduleNotification(for date: Date) {
        let incompleteHabits = data.getIncompleteHabits(for: settingsViewModel.selectedDate)
        
        if(!incompleteHabits.isEmpty){
            let habitTitles = incompleteHabits.map { $0.title }
            
            let habitsList = habitTitles.joined(separator: ", ")

            let title = "Rappel d'habitude"
            let body = "Vous avez des habitudes inachevées pour aujourd'hui : \(habitsList.lowercased())"
            
            notificationManager.scheduleNotification(date: date, title: title, body: body)
        } else{
            print("ok")
        }
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Notification.shared)
            .environmentObject(HabitsViewModel())
            .environmentObject(SettingsViewModel())
    }
}
