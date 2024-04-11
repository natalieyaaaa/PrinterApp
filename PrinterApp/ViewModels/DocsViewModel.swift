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
    @Published var currentDoc: Document?
    @Published var sharedImage: Image?
    
    var coreData = CoreDataManager.shared
    
    func getDocs() {
        docs = coreData.allEntities()
    }
    
    init() {
        getDocs()
    }
    
    func renameDoc() {
        guard currentDoc != nil else {return}
        currentDoc!.name = newDocName
        coreData.updateEntity()
        newDocName = ""
    }
    
    func deleteDoc() {
        guard currentDoc != nil else {return}
        coreData.deleteEntity(entity: currentDoc!)
        getDocs()
    }
    
}
