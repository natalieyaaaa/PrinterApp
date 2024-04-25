////
////  PaywallUp.swift
////  PrinterApp
////
////  Created by Наташа Яковчук on 25.04.2024.
////
//
//import SwiftUI
//
//struct PaywallUp: View {
//    var body: some View {
//                VStack(spacing: 16) {
//                    Spacer()
//                    
//                    VStack(spacing: 8) {
//                        Text(title)
//                            .font(Font.largeTitle.bold())
//                            .multilineTextAlignment(.center)
//                        
//                        Text(text)
//                            .multilineTextAlignment(.center)
//                            .font(Font.system(size: 19))
//                        
//                        HStack(spacing: 8) {
//                            ForEach([OnBoardingBottom.Tabs.first, .second, .third, .forth], id: \.self) { tab in
//                                Circle()
//                                    .frame(width: 8)
//                                    .foregroundColor(tab == selectedTab ? .obButton : .obButton2)
//                            }
//                        }
//                    }
//                    
//                    Button {
//                        withAnimation {
//                            switch selectedTab {
//                            case .first:
//                                selectedTab = .second
//                                let scenes = UIApplication.shared.connectedScenes
//                                if let windowScene = scenes.first as? UIWindowScene {
//                                    SKStoreReviewController.requestReview(in: windowScene)
//                                }
//                            case .second:
//                                selectedTab = .third
//                            case .third:
//                                selectedTab = .forth
//                            case .forth:
//                                break
//                            }
//                        }
//                    } label: {
//                        Text("Continue")
//                            .foregroundStyle(.white)
//                            .frame(width: 350, height: 42, alignment: .center)
//                        
//                    }
//                    .padding(.vertical, 12)
//                    .background(RoundedRectangle(cornerRadius: 31).foregroundStyle(.obButton))
//                    
//                }.background(BackgroundOB())
//            }
//        }
//    
//#Preview {
//    PaywallUp()
//}
