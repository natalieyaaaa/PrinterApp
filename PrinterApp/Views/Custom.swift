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

public struct BackgroundOB: View {
    var image: String
  public var body: some View {
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
            
            Image(image)
                .padding(.horizontal)
                .padding(.top, 127)
                .padding(.bottom, 199)
            
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
