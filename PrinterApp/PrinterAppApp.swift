//
//  PrinterAppApp.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI

@main
struct PrinterAppApp: App {
    @StateObject private var wvm = WebViewModel()
    @StateObject private var pvm = PrinterViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .onTapGesture {hideKeyboard()}
                .environmentObject(pvm)
                .environmentObject(wvm)
        }
    }
}

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }


