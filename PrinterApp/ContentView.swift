//
//  ContentView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 2

    @EnvironmentObject var vm: ScannerViewModel
    @State var isScanner = false

    var body: some View {
        TabView(selection: $selection) {
            
            VStack{}
                .tabItem { Label("Scanner", systemImage: "scanner") }
                .tag(1)
               
            
            HomeView()
                .tabItem { Label("Printer", systemImage: "printer") }
                .tag(2)
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(3)
            
        }.onChange(of: selection, {
            if selection == 1 {
                isScanner = true
            }
        })
        .fullScreenCover(isPresented: $isScanner, content: {
            ScannerView(selection: $selection)
                .environmentObject(vm)
        })
    }
}

#Preview {
    ContentView()
}
