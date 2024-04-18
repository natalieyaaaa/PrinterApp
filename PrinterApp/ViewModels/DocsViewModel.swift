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
//    @Published var sharedImage: Image?
    
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
    
    func shareImage() {
          guard let image = UIImage(named: "example_image") else {
              return
          }
          
          // Save the image to a temporary file
          do {
              let fileURL = try saveImageToTemporaryFile(image: image)
              
              // Share the temporary file
              if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                  if let rootViewController = windowScene.windows.first?.rootViewController {
                      let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                      rootViewController.present(vc, animated: true)
                  }
              }
          } catch {
              print("Error saving image to temporary file: \(error)")
          }
      }
      
      func saveImageToTemporaryFile(image: UIImage) throws -> URL {
          let temporaryDirectory = FileManager.default.temporaryDirectory
          let fileURL = temporaryDirectory.appendingPathComponent("shared_image.jpg")
          let imageData = image.jpegData(compressionQuality: 1.0)
          try imageData?.write(to: fileURL)
          return fileURL
      }
}
