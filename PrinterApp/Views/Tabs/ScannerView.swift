//
//  ScannerView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 13.03.2024.
//

//import SwiftUI
//import VisionKit
//
//struct ScannerView: View {
//    @State var showScaner = false
//    @State var pickedImages: [UIImage] = []
//    var body: some View {
//        VStack {
//            ScrollView {
//                ForEach(0..<pickedImages.count, id: \.self) { index in
//                        Image(uiImage: pickedImages[index])
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .padding(30)
//                    }
//            }
//            
//            Button {
//                showScaner = true
//            } label: {
//                Text("Open")
//            }.buttonStyle(.borderedProminent)
//        }
//        .documentScanner(isPresented: $showScaner) { result in
//            switch result {
//            case .success(let success):
//                pickedImages = success
//            case .failure(let error):
//                print("")
//            }
//        }
//    }
//}
//
//
//#Preview {
//    ScannerView()
//       
//}
