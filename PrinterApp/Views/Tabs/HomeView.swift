//
//  HomeView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 12.03.2024.
//

import SwiftUI
import _PhotosUI_SwiftUI
import UIKit

struct HomeView: View {
    
    @EnvironmentObject var pvm: PrinterViewModel
    
    @State private var showFileImporter = false
    @State private var isShowingImagePicker = false
    @State private var isShowingCamera = false
    @State private var isShowingPrintText = false
    @State private var isShowingWebPrint = false
    @State private var isShowinпDocsPrint = false
            
    var body: some View {
        
        VStack {
            HStack {
                Text("**Printer**")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .padding(.leading)
                
                Spacer()
                
                Image("pro")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
            }
            
            HStack {
                Button {
                    showFileImporter = true
                } label: {
                    MainOptions(text: "From Files", image: "files")
                }.onChange(of: pvm.fileURLPrint) { new in
                    pvm.printFile()
                }
                
                Spacer()
                    .frame(width: 16)
                
                Button {
                    isShowingImagePicker = true
                } label: {
                    MainOptions(text: "From Photos", image: "gallery")
                }.onChange(of: isShowingImagePicker) { new in
                    pvm.printImages()
                }
                
            }.padding(.horizontal)
            
            HStack {
                Image("printer")
                Text("What to print")
                    .font(.title3)
                    .fontWeight(.semibold)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: 16) {
                Button {isShowingCamera = true} label: {PrintOption(textMain: "Take Photo", textSub: "Take & Print", image: "camera")}
                
                Button {isShowingPrintText = true} label: {
                    PrintOption(textMain: "Print Text", textSub: "Type & Print text", image: "text")}
                
                Button{isShowingWebPrint = true} label: {
                    PrintOption(textMain: "Web", textSub: "Print web page", image: "web")
                }
                
                Button{isShowinпDocsPrint = true} label: {
                    PrintOption(textMain: "Documents", textSub: "Print scanned docs", image: "email")
                }
                
            }.padding(.horizontal)
            
            
            Spacer()
            
        }.padding(.top, 10)
        
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf], allowsMultipleSelection: false) { result in
                switch result {
                case .success(let files):
                    files.forEach { file in
                        let gotAccess = file.startAccessingSecurityScopedResource()
                        if !gotAccess { return }
                        pvm.fileURLPrint = file
                        file.stopAccessingSecurityScopedResource()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(images: $pvm.imagesPrint)
            }
        
            .fullScreenCover(isPresented: $isShowingCamera) {
                CameraView(isPresented: $isShowingCamera) { result in
                    if !result.isEmpty {
                        pvm.photosPrint = result
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { pvm.printPhotos()}
                    }
                }.ignoresSafeArea(.all)
            }
        
            .fullScreenCover(isPresented: $isShowingPrintText, content: {
                PrintTextView()
                    .environmentObject(pvm)
            })
        
            .fullScreenCover(isPresented: $isShowingWebPrint, content: {
                PrintWebView()
                    .environmentObject(pvm)
            })
        
            .fullScreenCover(isPresented: $isShowinпDocsPrint, content: {
                PrintDocumentsView()
                    .environmentObject(pvm)
            })
    }
    
}


#Preview {
    HomeView()
        .environmentObject(PrinterViewModel())
}



