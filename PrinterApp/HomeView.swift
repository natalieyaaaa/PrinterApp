//
//  HomeView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                Image("pro")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                
                Text("Printer")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.customDarkBlue, .customMediumBlue, .customLightBlue]), startPoint: .topLeading, endPoint: .bottom))
                            .frame(width: 175, height: 150)
                        
                        VStack {
                            Image("files")
                            
                            Text("From Files")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.top, 10)
                        }
                    }
                    
                    Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.customDarkBlue, .customMediumBlue, .customLightBlue]), startPoint: .topLeading, endPoint: .bottom))
                                .frame(width: 175, height: 150)
                            
                            VStack {
                                Image("gallery")
                                
                                Text("From Photos")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.top, 10)
                            }
                        }
                }.padding(.horizontal)
                    
                HStack {
                    
                    Image("printer")
                    Text("What to print")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                VStack {
                    
                    HStack {
                        Image("camera")
                        VStack(alignment: .leading) {
                            Text("Take photo")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("Take & Print")
                                .font(.body)
                                .foregroundStyle(.gray)
                        } .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        Image("arrow")
                        
                    }.padding()
                }
                
                
                Spacer()

                }
            }
        }
    }


#Preview {
    HomeView()
}
