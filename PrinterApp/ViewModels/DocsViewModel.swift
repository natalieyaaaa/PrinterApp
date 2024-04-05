//
//  DocsViewModel.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 05.04.2024.
//

import Foundation
import CoreData

final class DocsViewModel: ObservableObject {
    
    @Published var docs = [Document]()
    
    var coreData = CoreDataManager.shared
    
    func getDocs() {
        docs = coreData.allEntities()
    }
    
     init() {
        getDocs()
    }
}
