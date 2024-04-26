//
//  OnBoardingUp.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 25.04.2024.
//

import SwiftUI

struct OnBoardingUp: View {
    
    enum Tabs {
        case first
        case second
        case third
        case forth
    }
    
    @State var selectedTab: Tabs = .first
    
    var body: some View {
        
        switch selectedTab {
        case .first:
            OnBoardingUpTemplate(selectedTab: $selectedTab, title: "Connect\n to any printers", text: "Effortlessly connect to over 8,000 supported\n printers of all brands", image: "ob1")
        case .second:
            OnBoardingUpTemplate(selectedTab: $selectedTab, title: "Scan and Print\n Documents", text: "Scan any file and print it\n on your printer", image: "ob2")
        case .third:
            OnBoardingUpTemplate(selectedTab: $selectedTab, title: "Import Files from\n Anywhere", text: "Easily import docs from iCloud, Files, Photo,\n and Scanner", image: "ob3")
        case .forth:
            OnBoardingUpTemplate(selectedTab: $selectedTab, title: "Print in various\n Formats", text: "Supports the import of various formats for\n fast and convenient printing", image: "ob4")
            
        }
    }
}

struct OnBoardingUpTemplate: View {
    
    @Binding var selectedTab: OnBoardingUp.Tabs
    
    var title: String
    var text: String
    var image: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Spacer()
                
                VStack(spacing: 8) {
                    Text(title)
                        .font(Font.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    
                    Text(text)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 19))
                }
                
                Button {
                    triggerHapticFeedback()
                    withAnimation {
                        switch selectedTab {
                        case .first:
                            selectedTab = .second
                        case .second:
                            selectedTab = .third
                        case .third:
                            selectedTab = .forth
                        case .forth:
                            break
                        }
                    }
                } label: {
                    Text("Continue")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 17, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 42)
                        .padding(.vertical, 12)
                        .background(RoundedRectangle(cornerRadius: 31).foregroundStyle(.obButton))
                    
                }.padding(.horizontal)
                
            }.background(BackgroundOB(image: image))
        }
    }
}

#Preview {
    OnBoardingUp()
}

