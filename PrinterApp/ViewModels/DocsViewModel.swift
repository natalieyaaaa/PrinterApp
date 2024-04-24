//
//  DocsViewModel.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 05.04.2024.
//

import Foundation
import CoreData
import SwiftUI

final class DocsViewModel: ObservableObject {
    
    @Published var docs = [Document]()
    @Published var showChangeName = false
    @Published var showDeleteDoc = false
    @Published var newDocName = ""
    
    
    var coreData = CoreDataManager.shared
    
    func getDocs() {
        docs = coreData.allEntities()
    }
    
    init() {
        getDocs()
    }
    
    func renameDoc(entity: Document) {
        entity.name = newDocName
        coreData.updateEntity()
        newDocName = ""
    }
    
    func deleteDoc(entity: Document) {
        coreData.deleteEntity(entity: entity)
        getDocs()
    }
    
}

