//
//  ScannerView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 13.03.2024.
//

import SwiftUI
import VisionKit

struct ScannerView: View {
    
    @EnvironmentObject var vm: ScannerViewModel
    
    var body: some View {
        
        switch vm.dataScannerAccessStatus {
            
                case .scannerAvailable:
                    mainView
                case .cameraNotAvailable:
                    Text("Your device doesn't have a camera")
                case .scannerNotAvailable:
                    Text("Your device doesn't have support for scanning barcode with this app")
                case .cameraAccessNotGranted:
                    Text("Please provide access to the camera in settings")
                case .notDetermined:
                    Text("Requesting camera access")
                }
            }
            
            private var mainView: some View {
                
                DataScannerView(
                    recognizedItems: $vm.recognizedItems,
                    recognizedDataType: vm.recognizedDataType,
                    recognizesMultipleItems: vm.recognizesMultipleItems)
                
                .background { Color.gray.opacity(0.3) }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                
                .sheet(isPresented: .constant(true)) {
                    
                    bottomContainerView
                        .background(.ultraThinMaterial)
                        .presentationDetents([.medium, .fraction(0.25)])
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                        .onAppear {
                            
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                                return
                            }
                            controller.view.backgroundColor = .clear
                        }
                }
                .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = []}
            }
            
            private var headerView: some View {
                VStack {
                    HStack {
                        Picker("Scan Type", selection: $vm.scanType) {
                            Text("Barcode").tag(ScanType.barcode)
                            Text("Text").tag(ScanType.text)
                        }.pickerStyle(.segmented)
                        
                        Toggle("Scan multiple", isOn: $vm.recognizesMultipleItems)
                    }.padding(.top)
                    
//                    if vm.scanType == .text {
//                        Picker("Text content type", selection: $vm.textContentType) {
//                            ForEach(textContentTypes, id: \.self.textContentType) { option in
//                                Text(option.title).tag(option.textContentType)
//                            }
//                        }.pickerStyle(.segmented)
//                    }
                    
                    Text(vm.headerText).padding(.top)
                }.padding(.horizontal)
            }
            
            private var bottomContainerView: some View {
                VStack {
                    headerView
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(vm.recognizedItems) { item in
                                switch item {
                                case .barcode(let barcode):
                                    Text(barcode.payloadStringValue ?? "Unknown barcode")
                                    
                                case .text(let text):
                                    Text(text.transcript)
                                    
                                @unknown default:
                                    Text("Unknown")
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }

#Preview {
    ScannerView()
}


//MARK: -

struct DataScannerView: UIViewControllerRepresentable {
    
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .balanced,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }
    
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        @Binding var recognizedItems: [RecognizedItem]

        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
            print("didAddItems \(addedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItems = recognizedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id })
            }
            print("didRemovedItems \(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("became unavailable with error \(error.localizedDescription)")
        }
        
    }
    
}
