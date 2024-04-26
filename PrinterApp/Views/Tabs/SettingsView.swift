//
//  SettingsView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 13.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    let url = URL(string: "https://apps.apple.com/us/app/light-speedometer/id6447198696")!

    var body: some View {
        NavigationView {
            VStack {
                Text("Settings")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .font(Font.headline.weight(.bold))
                    .padding(.leading)
                
                VStack(spacing: 16) {
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        SettingsOptions(text: "Printer PRO", image: "pro.small")})
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        SettingsOptions(text: "FAQ", image: "FAQ")})
                    
                    Link(destination: URL(string: "https://www.apple.com")!,label: {
                        SettingsOptions(text: "Contact us", image: "mail")})
                    
                    Button {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let viewController = windowScene.windows.first?.rootViewController else {
                            return
                        }
                        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                        viewController.present(av, animated: true, completion: nil)
                        
                    } label: {
                        SettingsOptions(text: "Share", image: "share")}
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        SettingsOptions(text: "Terms of Use", image: "notes")})
                    
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        SettingsOptions(text: "Privacy Policy", image: "privacy")})
                    
                }.padding(.horizontal)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    SettingsView()
}

