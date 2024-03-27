//
//  ContentView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 2

    @State var showScanner = false

    @State var pickedImages: [UIImage] = []

    var body: some View {
        ZStack {
            Group {
                if selection == 1 {
                    HomeView()
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
                            Image(systemName: "scanner")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                            Text("Scanner")
                                .font(.system(size: 15))
                        }
                    }.foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button {
                        selection = 1
                    } label: {
                        VStack {
                            Image(systemName: "printer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                            
                            Text("Printer")
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        selection = 2
                    } label: {
                        VStack {
                            Image(systemName: "gearshape")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                            Text("Settings")
                        }
                    }
                }.padding()
                    .padding(.bottom, 50)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .offset(y: 50)
            }.zIndex(2)
        }
        .documentScanner(isPresented: $showScanner) { result in
            switch result {
            case .success(let success):
                pickedImages = success
            case .failure(let error):
                print("")
            }
        }
    }
}

#Preview {
    ContentView()
}
