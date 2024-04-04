//
//  PrinterViewModel.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 29.03.2024.
//

import Foundation
import SwiftUI
import UIKit
import _PhotosUI_SwiftUI
import PDFKit
import WebKit

final class PrinterViewModel: ObservableObject {
    
    @Published var imagesPrint = [UIImage]()
    @Published var fileURLPrint: URL?
    @Published var photosPrint = [UIImage]()
    @Published var textPrint = ""
    
    let wvm = WebViewModel.shared
    
    func printImages() {
        let printController = UIPrintInteractionController.shared
        printController.printingItems = imagesPrint
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при открытии контроллера печати: \(error.localizedDescription)")
            } else if completed {
                print("Печать завершена успешно")
            } else {
                print("Печать отменена")
            }
            
            self.imagesPrint.removeAll()
        }
    }
    
    func printFile() {
        guard let selectedFileUrl = fileURLPrint else {
            print("No file selected")
            return
        }
        
        guard selectedFileUrl.startAccessingSecurityScopedResource() else {
            print("Failed to access file")
            return
        }
        
        defer {
            selectedFileUrl.stopAccessingSecurityScopedResource()
        }
        
        do {
            let fileData = try Data(contentsOf: selectedFileUrl)
            let printController = UIPrintInteractionController.shared
            printController.printingItem = fileData as Any
            printController.present(animated: true) { (controller, completed, error) in
                if let error = error {
                    print("Error presenting print controller: \(error.localizedDescription)")
                } else if completed {
                    print("Printing completed successfully")
                } else {
                    print("Printing canceled")
                }
            }
        } catch {
            print("Error reading file data: \(error.localizedDescription)")
        }
    }
    
    func printPhotos() {
        let printController = UIPrintInteractionController.shared
        printController.printingItems = photosPrint
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при открытии контроллера печати: \(error.localizedDescription)")
            } else if completed {
                print("Печать завершена успешно")
            } else {
                print("Печать отменена")
            }
            
            self.photosPrint.removeAll()
        }
    }
    
    func printText() {
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printController.printInfo = printInfo
        let printFormatter = UIMarkupTextPrintFormatter(markupText: textPrint)
        printController.printFormatter = printFormatter
        
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при открытии контроллера печати: \(error.localizedDescription)")
            } else if completed {
                print("Печать завершена успешно")
            } else {
                print("Печать отменена")
            }
            
            self.textPrint = ""
        }
        
    }
    
    func printWebPage() {
        guard wvm.showedURL != "" else { return }
        wvm.webView.loadURL(urlString: wvm.showedURL)
        guard UIPrintInteractionController.isPrintingAvailable else {
            print("Принтер недоступен")
            return
        }
        
        let printFormatter = wvm.webView.webView.viewPrintFormatter()
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        printInfo.jobName = "Печать веб-страницы"
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = false
        printController.printFormatter = printFormatter
        
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при печати: \(error.localizedDescription)")
            }
        }
    }
    
    
}
