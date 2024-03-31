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
    
    public var scannedImages: [UIImage] = [] // New property to store scanned images
    public var onCompletion: (Result<[UIImage], Error>) -> Void
    public var saveURL: URL? // Add a parameter for specifying the save location

    
    /// Creates a scanner that scans documents.
    /// - Parameter onCompletion: A callback that will be invoked when the scanning operation has succeeded or failed.
    public init(onCompletion: @escaping (Result<[UIImage], Error>) -> Void, saveURL: URL? = nil) {
         self.onCompletion = onCompletion
         self.saveURL = saveURL // Initialize the saveURL parameter
     }
    
    /// Creates a scanner that scans documents.
    /// - Parameter onCompletion: A callback that will be invoked when the scanning operation has succeeded or failed.
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
    
    /// A Boolean variable that indicates whether or not the current device supports document scanning.
    ///
    /// This class method returns `false` for unsupported hardware.
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
        
        init(_ parent: DocumentScannerView) {
            self.parent = parent
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let scannedImages = (0..<scan.pageCount).map(scan.imageOfPage(at:))
            parent.scannedImages.append(contentsOf: scannedImages) // Append scanned images to the array
            parent.onCompletion(.success(parent.scannedImages)) // Pass the array in the completion handler
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
        GeometryReader { geo in
            ZStack {
                // this color makes sure that its enclosing ZStack
                // (and the GeometryReader) fill the entire screen,
                // allowing to know its full height
                Color.clear
                content
                ZStack {
                    // the color is here for the cover to fill
                    // the entire screen regardless of its content
                    Color.white
                    self.content()
                }
                .offset(y: isPresented ? 0 : geo.size.height)
                // feel free to play around with the animation speeds!
                .animation(.spring())
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
