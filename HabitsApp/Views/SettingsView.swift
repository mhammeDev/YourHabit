import SwiftUI

struct SettingsView: View {
    @State private var username: String = ""
    @State private var isChecked = false
    @State private var isDarkModeEnabled = false

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
            
            Toggle("Notification push", isOn: $isChecked)
                .padding(.horizontal)
            
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
