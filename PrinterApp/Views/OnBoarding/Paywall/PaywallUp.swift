//
//  PaywallUp.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 25.04.2024.
//

import SwiftUI

struct PaywallUp: View {
    @State var isFreeTrial = false
    var body: some View {
                VStack(spacing: 16) {
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(.leading)
                    Spacer()
                    
                    VStack(spacing: 8) {
                        Text("Set up printing\n Features")
                            .font(Font.largeTitle.bold())
                            .multilineTextAlignment(.center)
                        
                        Text("Start a Printer app with no limits just for\n $6.99/week.")
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 19))
                        
                    }
                    
                    VStack(spacing: 8) {
                        
                        HStack {
                            Text("I want my free trial")
                            Toggle("", isOn: $isFreeTrial)
                                .tint(.obButton)
                        }.frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 32).foregroundStyle(.obButton2))
                            .padding(.horizontal,16)
                        
                        Button {
                            triggerHapticFeedback()

                        } label: {
                            VStack{
                                Text(isFreeTrial ? "3-day Free Trial then $6.99/week" : "Subscribe for $6.99/week")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                                    
                                Text("Cancel anytime")
                                    .foregroundStyle(.white)
                                    .font(Font.system(size: 15))

                            }.frame(maxWidth: .infinity)
                                .padding()
                            .background(RoundedRectangle(cornerRadius: 33).foregroundStyle(.obButton))
                        }.padding(.horizontal,16)
                        
                        HStack {
                            Link(destination: URL(string: "https://www.apple.com")!, label: {
                                Text("Privacy Policy")})
                            Spacer()
                            Link(destination: URL(string: "https://www.apple.com")!, label: {
                                Text("Restore")})
                            Spacer()
                            Link(destination: URL(string: "https://www.apple.com")!, label: {
                                Text("Terms of Use")})
                        }.foregroundStyle(.gray)
                            .font(Font.system(size: 15))
                            .padding(.horizontal, 32)
                    
                    }
                }.background(BackgroundOB(image: "paywallUp"))
            }
        }
    
#Preview {
    PaywallUp()
}
