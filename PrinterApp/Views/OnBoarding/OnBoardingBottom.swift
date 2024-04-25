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
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Connect\n to any printers", text: "Effortlessly connect to over 8,000 supported\n printers of all brands", image: "ob1", paddingH: 26, paddingT: 205, paddingB: 397)
        case .second:
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Scan and Print\n Documents", text: "Scan any file and print it\n on your printer", image: "ob2", paddingH: 18, paddingT: 94, paddingB: 242)
        case .third:
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Import Files from\n Anywhere", text: "Easily import docs from iCloud, Files, Photo,\n and Scanner", image: "ob3", paddingH: 87, paddingT: 225, paddingB: 451)
        case .forth:
            OnBoardingDownTemplate(selectedTab: $selectedTab, title: "Print in various\n Formats", text: "Supports the import of various formats for\n fast and convenient printing", image: "ob4", paddingH: 16, paddingT: 240, paddingB: 452)

            
        }
    }
}


struct OnBoardingDownTemplate: View {
    
    @Binding var selectedTab: OnBoardingBottom.Tabs

    var title: String
    var text: String
    var image: String
    var paddingH: CGFloat
    var paddingT: CGFloat
    var paddingB: CGFloat
    
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
                    
                    HStack(spacing: 8) {
                        ForEach([OnBoardingBottom.Tabs.first, .second, .third, .forth], id: \.self) { tab in
                            Circle()
                                .frame(width: 8)
                                .foregroundColor(tab == selectedTab ? .obButton : .obButton2)
                        }
                    }
                }
                
                Button {
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
                        .frame(width: 350, height: 42, alignment: .center)
                    
                }
                .padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 31).foregroundStyle(.obButton))
                
            }.background(BackgroundOB1().overlay {
                Image(image)
                    .padding(.horizontal, paddingH)
                    .padding(.top, paddingT)
                    .padding(.bottom, paddingB)
            })
        }
    }
}

#Preview {
    OnBoardingBottom()
}

struct BackgroundOB1: View {
    var body: some View {
        ZStack {
            Image("bgPrinter")
                .padding(.trailing, 275.5)
                .padding(.top, 70)
                .padding(.bottom, 692.5)
                .padding(.leading, 15)
            
            Image("bgFolder")
                .padding(.trailing, 190)
                .padding(.top, 35)
                .padding(.bottom, 807)
                .padding(.leading, 154)
            
            Image("bgFile")
                .padding(.trailing, -8.7)
                .padding(.top, 47)
                .padding(.bottom, 726)
                .padding(.leading, 277)
            
            Image("bgWifi")
                .padding(.top, 244)
                .padding(.bottom, 539)
                .padding(.leading, 300)
            
            Image("bgFile2")
                .padding(.trailing, 330)
                .padding(.top, 293)
                .padding(.bottom, 506)
                .padding(.leading, -34)
            
            Image("bgPrinter2")
                .padding(.trailing, -18)
                .padding(.top, 442)
                .padding(.bottom, 350)
                .padding(.leading, 307)
            
            Image("bgFolder2")
                .padding(.trailing, 292)
                .padding(.top, 499)
                .padding(.bottom, 284)
                .padding(.leading, -27)
            
            Image("iPhone")
                .padding(.top, -1.9)
            
            VStack {
                Spacer()
                
                Rectangle()
                    .frame(width: .infinity, height: 422)
                    .foregroundStyle(LinearGradient(stops: [
                        Gradient.Stop(color: Color(.clear), location: 0.00),
                        Gradient.Stop(color: Color(.white), location: 0.18),],
                                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                                   ))
            }
        }
    }
}
