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
    
}
