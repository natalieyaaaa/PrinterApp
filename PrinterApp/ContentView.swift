//
//  ContentView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var pvm: PrinterViewModel
    @EnvironmentObject var wvm: WebViewModel

    @State var selection = 1

    @State var showScanner = false

    @State var pickedImages: [UIImage] = []

    var body: some View {
        ZStack {
            Group {
                if selection == 1 {
                    HomeView()
                        .environmentObject(pvm)
                } else if selection == 2 {
                    SettingsView()
                }
            }.zIndex(1)
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        showScanner = true
                    } label: {
                        VStack {
                            Image("scanner")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                            Text("Scanner")
                                .font(.system(size: 14))
                        }
                    }.foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button {
                        selection = 1
                    } label: {
                        VStack {
                            Image("printer")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .tint(.gray)
                            Text("Printer")
                                .font(.system(size: 14))
                        }.foregroundStyle(selection == 1 ? .blue : .gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        selection = 2
                    } label: {
                        VStack {
                            Image("settings")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                            Text("Settings")
                                .font(.system(size: 14))
                        }.foregroundStyle(selection == 2 ? .blue : .gray)
                    }
                    
                }.padding(.horizontal, 20)
                .padding(.top, 5)
                    .padding(.bottom, 30)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .offset(y: 40)
                
            }.zIndex(2)
        }
        .documentScanner(isPresented: $showScanner) { result in
            switch result {
            case .success(let success):
                pickedImages = success
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PrinterViewModel())
        .environmentObject(WebViewModel())
}
