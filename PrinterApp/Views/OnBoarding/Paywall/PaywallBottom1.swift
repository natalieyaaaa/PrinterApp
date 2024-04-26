//
//  PaywallButton.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 26.04.2024.
//

import SwiftUI

struct PaywallBottom1: View {
    @State var isXmarkShowing = false
    var body: some View {
        VStack(spacing: 16) {
            
            if isXmarkShowing {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(.leading)
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Text("Set up printing\n Features")
                    .font(Font.largeTitle.bold())
                    .multilineTextAlignment(.center)
                
                Text("Start a 3-day free trial of Printer app with no\n limits just for $6.99/week.")
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 19))
                    .foregroundStyle(.gray)
            }
            
            VStack(spacing: 8) {
                
                Button {
                    triggerHapticFeedback()

                } label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(Font.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 42)
                            .padding(.vertical, 12)
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
            .onAppear {DispatchQueue.main.asyncAfter(deadline: .now() + 5) {withAnimation{isXmarkShowing = true}}}
    }
}

#Preview {
    PaywallBottom1()
}
