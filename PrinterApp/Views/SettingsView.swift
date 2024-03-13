//
//  SettingsView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 13.03.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                
                VStack(spacing: 16) {
                    
                    NavigationLink{} label: {
                        SettingsOptions(text: "Printer PRO", image: "pro.small")}
                    
                    NavigationLink{} label: {
                        SettingsOptions(text: "FAQ", image: "FAQ")}
                    
                    NavigationLink{} label: {
                        SettingsOptions(text: "Contact us", image: "mail")}
                    
                    NavigationLink{} label: {
                        SettingsOptions(text: "Share", image: "share")}
                    
                    NavigationLink{} label: {
                        SettingsOptions(text: "Terms of Use", image: "notes")}
                    
                    NavigationLink{} label: {
                        SettingsOptions(text: "Privacy Policy", image: "privacy")}
                    
                }.padding(.horizontal)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    SettingsView()
}


struct SettingsOptions: View {
    
    var text = ""
    var image = ""
    
    var body: some View {
        
        HStack {
            Image(image)
                .padding(.trailing, 10)
            
            Text(text)
                .foregroundStyle(.black)
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image("arrow")
            
        } .padding()
            .background(RoundedRectangle(cornerRadius: 32).foregroundStyle(.white)
                .shadow(color: .gray.opacity(0.2), radius: 13, y: 8))
        
    }
}
