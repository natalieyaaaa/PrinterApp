//
//  PrinterViewModel.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 29.03.2024.
//

import Foundation
import PrintingKit
import SwiftUI
import UIKit
import _PhotosUI_SwiftUI


final class PrinterViewModel: ObservableObject {
    
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedImages = [Image]()
    
    let printer = Printer.shared
    
    func tryPrintItem(_ item: PrintItem?) {
        guard let item else { return }
        do {
            try printer.print(item)
        } catch {
            print(error)
        }
    }
    
    func printImage(image: Image) {
     
    }
}
