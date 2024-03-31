//
//  WelcomeView.swift
//  HabitsApp
//
//  Created by Momo la Squalle  on 31/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel

    
    var onContinue: () -> Void

    var body: some View {
        VStack {
            Spacer()

            Text("Bienvenue \(settingsViewModel.username), sur YourHabits!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("L'application de vos habitudes")
                .font(.title3)
                .padding()


            Image("LogoApp")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
                .cornerRadius(80)

            Text("Découvrez vos habitudes et commencez à les améliorer dès aujourd'hui.")
                .multilineTextAlignment(.center)
                .padding()

            Button(action: onContinue) {
                Text("Accéder à l'application")
                    .frame(width: 330)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(onContinue: {})
            .environmentObject(SettingsViewModel())
    }
}


