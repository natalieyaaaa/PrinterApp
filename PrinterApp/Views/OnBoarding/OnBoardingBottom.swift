//
//  OnBoardingBottom.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 25.04.2024.
//

import SwiftUI
import StoreKit


struct OnBoardingBottom: View {
    
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
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Connect\n to any printers", text: "Effortlessly connect to over 8,000 supported\n printers of all brands", image: "ob1")
        case .second:
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Scan and Print\n Documents", text: "Scan any file and print it\n on your printer", image: "ob2")
        case .third:
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Import Files from\n Anywhere", text: "Easily import docs from iCloud, Files, Photo,\n and Scanner", image: "ob3")
        case .forth:
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Print in various\n Formats", text: "Supports the import of various formats for\n fast and convenient printing", image: "ob4")

            
        }
    }
}


struct OnBoardingDownTemplate: View {
    
    @Binding var selectedTab: OnBoardingBottom.Tabs

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
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 8) {
                        ForEach([OnBoardingBottom.Tabs.first, .second, .third, .forth], id: \.self) { tab in
                            Circle()
                                .frame(width: 8)
                                .foregroundColor(tab == selectedTab ? .obButton : .obButton2)
                        }
                    }
                }
                
                Button {
                    triggerHapticFeedback()
                    withAnimation {
                        switch selectedTab {
                        case .first:
                            selectedTab = .second
                            let scenes = UIApplication.shared.connectedScenes
                            if let windowScene = scenes.first as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: windowScene)
                            }
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
                        .font(.system(size: 17, weight: .medium))
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
    OnBoardingBottom()
}

