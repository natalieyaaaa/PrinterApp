//
//  ScannerView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 13.03.2024.
//

import SwiftUI
import VisionKit

struct ScannerView: View {
    @Binding var selection: Int
    @EnvironmentObject var vm: ScannerViewModel
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            CameraScannerView(selection: $selection)
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
    
    
    
}

struct CameraScannerView: View {
    
    @Binding var selection: Int
    @EnvironmentObject var vm: ScannerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        DataScannerView(
            recognizedItems: $vm.recognizedItems,
            recognizedDataType: .text(),
            recognizesMultipleItems: vm.recognizesMultipleItems)
        
        .background { Color.gray.opacity(0.3) }
        .ignoresSafeArea(edges: .top)
        .id(vm.dataScannerViewId)
        
        .overlay {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.black.opacity(0.4))
                        .frame(height: 120)
                    
                    HStack{
                        Button {
                            dismiss()
                            selection = 2
                        } label: {
                            Text("Cancel")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                        
                        Spacer()
                        
                        Button {
                            vm.toggleFlash()
                        } label: {
                            Image(systemName: "bolt.circle.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 25))
                        }
                    }.padding(.top, 70)
                        .padding(.horizontal)
                }
                Spacer()
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    CameraScannerView(selection: .constant(1))
        .environmentObject(ScannerViewModel())
}
