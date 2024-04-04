//
//  ScannerViewModel.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 14.03.2024.
//

import SwiftUI
import VisionKit
import PDFKit

public struct DocumentScannerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode)
    private var presentationMode
    
    public var scannedImages: [UIImage] = []
    public var onCompletion: (Result<[UIImage], Error>) -> Void


    public init(onCompletion: @escaping (Result<[UIImage], Error>) -> Void) {
         self.onCompletion = onCompletion
     }

    public init(onCompletion: @escaping (Result<PDFDocument, Error>) -> Void) {
        self.onCompletion = { result in
            onCompletion(result.map { PDFDocument($0) })
        }
    }
    
    public func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let vc = VNDocumentCameraViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    public static var isSupported: Bool {
        VNDocumentCameraViewController.isSupported
    }
}

extension PDFDocument {
    public convenience init(_ images: [UIImage]) {
        self.init()
        for i in 0..<images.count {
            let pdfPage = PDFPage(image: images[i])
            self.insert(pdfPage!, at: i)
        }
    }
}


extension DocumentScannerView {
    public class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: DocumentScannerView
        
        let coreData = CoreDataManager.shared
        
        init(_ parent: DocumentScannerView) {
            self.parent = parent
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let currentDate = Date()
            let scannedImages = (0..<scan.pageCount).map(scan.imageOfPage(at:))
            parent.scannedImages.append(contentsOf: scannedImages) 
            if !scannedImages.isEmpty {
                for photo in scannedImages {
                    let imageData = photo.pngData()!
                    coreData.saveEntity(image: imageData, name: "PNG_\(currentDate.formatted(date: .abbreviated, time: .omitted))_Scanned", timeTaken: currentDate)
                }
            }
            parent.onCompletion(.success(parent.scannedImages))
            parent.dismiss()
        }
        
        public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.dismiss()
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Error:", error)
            parent.onCompletion(.failure(error))
            parent.dismiss()
        }
    }
}

struct FullScreenCoverCompat<CoverContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let content: () -> CoverContent
    
    func body(content: Content) -> some View {
        withAnimation(.spring()) {
            GeometryReader { geo in
                ZStack {
                    Color.clear
                    content
                    ZStack {
      
                        Color.white
                        self.content()
                    }
                    .offset(y: isPresented ? 0 : geo.size.height)

                }
            }
        }
    }
}

extension View {
    @available(iOS, obsoleted: 14, renamed: "fullScreenCover")
    func fullScreenCoverCompat<Content: View>(isPresented: Binding<Bool>,
                                              content: @escaping () -> Content) -> some View {
        self.modifier(FullScreenCoverCompat(isPresented: isPresented,
                                            content: content))
    }
}


extension View {
    @ViewBuilder
    public func documentScanner(
        isPresented: Binding<Bool>,
        onCompletion: @escaping (Result<[UIImage], Error>) -> Void
    ) -> some View {
        if #available(iOS 14, macCatalyst 14, visionOS 1, *) {
            fullScreenCover(isPresented: isPresented) {
                DocumentScannerView(onCompletion: onCompletion)
                    .ignoresSafeArea()
            }
        } else {
            fullScreenCover(isPresented: isPresented) {
                DocumentScannerView(onCompletion: onCompletion)
            }
        }
    }
}


