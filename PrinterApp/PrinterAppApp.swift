//
//  PrinterAppApp.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI

@main
struct PrinterAppApp: App {
    
    @StateObject private var vm = ScannerViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
                .preferredColorScheme(.light)
        }
    }
}
