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

struct DocView: View {
    @EnvironmentObject var dvm: DocsViewModel
    
    @Binding var doc: Document
    var body: some View {
        
        VStack(alignment: .leading) {
            Image(uiImage: UIImage(data: doc.image!)!)
                .resizable()
                .frame(width: 150, height: 100)
            
            Text(doc.name!)
                .font(Font.headline.weight(.semibold))
                .foregroundStyle(.black)
                .frame(width: 150)
                .lineLimit(1)
            
            HStack {
                Text(dateFormatter.string(from: doc.timeTaken!))
                    .font(Font.system(size: 12))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                
                Spacer()
                
                Menu {
                    
                    Button{
                        pvm.imagesPrint.append(UIImage(data: doc.image!)!)
                        pvm.printImages()
                    } label: {
                        Text("Print")
                        Spacer()
                        Image(systemName: "printer")
                    }.frame(width: 80)
                    
                    Button {
                        dvm.currentDoc = doc
                        dvm.showChangeName = true
                    } label: {
                        Text("Rename")
                        Spacer()
                        Image(systemName: "pencil.line")
                    }
                    
                    Button {
                        dvm.currentDoc = doc
                        dvm.showDeleteDoc = true
                    } label: {
                        Text("Delete")
                        Spacer()
                        Image(systemName: "trash")
                    }
                    
                    
                    Button {
                        dvm.shareImage = Image(UIImage(data: doc.image))
                    } label: {
                        Image(systemName: "list.bullet.circle.fill")
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                }
                    
                    
                }.frame(width: 150)
            }.padding(10)
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.white))
                .shadow(color: .gray.opacity(0.3), radius: 5)
    }
}

