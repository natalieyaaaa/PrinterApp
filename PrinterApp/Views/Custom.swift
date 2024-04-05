//
//  Custom.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 04.04.2024.
//

import Foundation
import SwiftUI

struct PrintOption: View {
    
    var textMain = ""
    var textSub = ""
    var image = ""
    
    var body: some View {
        
        HStack {
            Image(image)
            VStack(alignment: .leading) {
                Text(textMain)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(textSub)
                    .font(.body)
                    .foregroundStyle(.gray)
            } .padding(.horizontal, 10)
            
            Spacer()
            
            Image("arrow")
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 32).foregroundStyle(.white)
                .shadow(color: .gray.opacity(0.2), radius: 13, y: 8))
        
        
    }
}


struct MainOptions: View {
    
    var text = ""
    var image = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.customDarkBlue, .customMediumBlue, .customLightBlue]), startPoint: .topLeading, endPoint: .bottom))
                .frame(width: 175, height: 150)
            
            VStack {
                Image(image)
                
                Text("**\(text)**")
                    .font(.title2)
                    .font(Font.headline.weight(.bold))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
            }
        }.shadow(color: .gray.opacity(0.2), radius: 10, y: 10)
        
    }
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
                .font(Font.headline.weight(.semibold))

            Spacer()
            
            Image("arrow")
            
        } .padding()
            .background(RoundedRectangle(cornerRadius: 32).foregroundStyle(.white)
                .shadow(color: .gray.opacity(0.2), radius: 13, y: 8))
        
    }
}

