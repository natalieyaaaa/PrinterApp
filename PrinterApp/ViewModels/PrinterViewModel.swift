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


final class PrinterViewModel: ObservableObject {
    
    @Published var selectedImages = [UIImage]()
    @Published var selectedFileUrl: URL?
    @Published var takenPhotos = [UIImage]()
    
    func printImages() {
        // Создание UIPrintInteractionController для печати
        let printController = UIPrintInteractionController.shared
        
        // Установка изображения для печати
        printController.printingItems = selectedImages
        // Открытие контроллера печати для выбора принтера и настройки печати
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при открытии контроллера печати: \(error.localizedDescription)")
            } else if completed {
                print("Печать завершена успешно")
            } else {
                print("Печать отменена")
            }
            
            self.selectedImages.removeAll()
        }
    }
    
    func printFile() {
        guard let selectedFileUrl = selectedFileUrl else {
            print("No file selected")
            return
        }
        
        // Запрашиваем доступ к файлу
        guard selectedFileUrl.startAccessingSecurityScopedResource() else {
            print("Failed to access file")
            return
        }
        
        defer {
            // Освобождаем доступ к файлу после окончания использования
            selectedFileUrl.stopAccessingSecurityScopedResource()
        }
        
        do {
            // Читаем содержимое файла
            let fileData = try Data(contentsOf: selectedFileUrl)
            
            // Создаем контроллер интеракции печати для печати
            let printController = UIPrintInteractionController.shared
            
            // Устанавливаем документ для печати
            printController.printingItem = fileData as Any
            
            // Показываем контроллер печати для выбора принтера и настроек печати
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
        // Создание UIPrintInteractionController для печати
        let printController = UIPrintInteractionController.shared
        
        // Установка изображения для печати
        printController.printingItems = takenPhotos
        // Открытие контроллера печати для выбора принтера и настройки печати
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при открытии контроллера печати: \(error.localizedDescription)")
            } else if completed {
                print("Печать завершена успешно")
            } else {
                print("Печать отменена")
            }
            
            self.takenPhotos.removeAll()
        }
    }
    
    
}
