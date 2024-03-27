import SwiftUI

struct SettingsView: View {
    @State private var username: String = ""
    @State private var isChecked = false
    @State private var isDarkModeEnabled = false
    @State private var pushNotificationEnabled = false
    @State private var notificationTimes: [Date] = []
    @State private var newNotificationTime = Date()




    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Réglages")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
            
            TextField("Entrez votre nom d'utilisateur", text: $username)
                .padding()
                .frame(height: 55)
                .background(Color(.systemGray4))
                .cornerRadius(10)
                .padding(.horizontal)

            Toggle("Message Accueil", isOn: $isChecked)
                .padding(.horizontal)
            
            Toggle("Notification push", isOn: $pushNotificationEnabled)
                .padding(.horizontal)
                .onChange(of: pushNotificationEnabled, perform: { value in
                    if value {
                        // Activer les notifications push
                    } else {
                        // Désactiver les notifications push
                    }
                })
            
            if pushNotificationEnabled {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Créneaux horaires pour les notifications:")
                        .padding(.leading)
                    ForEach(notificationTimes, id: \.self) { time in
                        Text(dateFormatter.string(from: time))
                            .padding(.leading)
                    }
                    HStack {
                        DatePicker("", selection: $newNotificationTime, displayedComponents: .hourAndMinute)
                            .padding(.horizontal)
                        Button("Ajouter") {
                            notificationTimes.append(newNotificationTime)
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
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
