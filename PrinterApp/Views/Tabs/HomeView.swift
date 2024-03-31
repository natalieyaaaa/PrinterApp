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
    
    @State private var showProSubScreen = false
    @State private var showFileImporter = false
    @State private var isShowingImagePicker = false
    @State private var isShowingCamera = false
    
    @State private var capturedImages: [UIImage] = []
    
    var handlePickedPDF: (URL) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    
                    Text("Printer")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
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
                    }.onChange(of: pvm.selectedFileUrl) {pvm.printFile()}
                    
                    Spacer()
                        .frame(width: 16)
                    
                    Button {
                        isShowingImagePicker = true
                    } label: {
                        MainOptions(text: "From Photos", image: "gallery")
                    }.onChange(of: isShowingImagePicker) {
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
                    
                    Button {
                        isShowingCamera = true
                    } label: {
                        PrintOption(textMain: "Take Photo", textSub: "Take & Print", image: "camera")
                    }
                    
                    NavigationLink{} label: {
                        PrintOption(textMain: "Print Text", textSub: "Type & Print text", image: "text")}
                    
                    NavigationLink{} label: {
                        PrintOption(textMain: "Email", textSub: "Print your emails", image: "email")}
                    
                    NavigationLink{} label: {
                        PrintOption(textMain: "Web", textSub: "Print web page", image: "web")
                    }
                    
                }.padding(.horizontal)
                
                
                Spacer()
                
            }
        }/*.fullScreenCover(isPresented: $showProSubScreen, content: {})*/
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf], allowsMultipleSelection: false) { result in
                switch result {
                case .success(let files):
                    files.forEach { file in
                        // gain access to the directory
                        let gotAccess = file.startAccessingSecurityScopedResource()
                        if !gotAccess { return }
                        // access the directory URL
                        // (read templates in the directory, make a bookmark, etc.)
                        pvm.selectedFileUrl = file
                        // release access
                        file.stopAccessingSecurityScopedResource()
                    }
                case .failure(let error):
                    // handle error
                    print(error)
                }
            }
        .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(images: $pvm.selectedImages)
            }
            
        .fullScreenCover(isPresented: $isShowingCamera) {
            CameraView(isPresented: $isShowingCamera) { result in
                if !result.isEmpty {
                    pvm.takenPhotos = result
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { pvm.printPhotos()}
                }
            }.ignoresSafeArea(.all)
        }
    }
    
}


#Preview {
    HomeView(handlePickedPDF: {_ in })
        .environmentObject(PrinterViewModel())
}



struct PrintOption: View {
    
    var textMain = ""
    var textSub = ""
    var image = ""
    
    var body: some View {
        
        HStack {
            Image(image)
            VStack(alignment: .leading) {
                Text(textMain)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(textSub)
                    .font(.body)
                    .foregroundStyle(.gray)
            } .padding(.horizontal, 10)
            
            Spacer()
            
            Image("arrow")
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 32).foregroundStyle(.white)
                .shadow(color: .gray.opacity(0.2), radius: 13, y: 8))
        
        
    }
}


struct MainOptions: View {
    
    var text = ""
    var image = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.customDarkBlue, .customMediumBlue, .customLightBlue]), startPoint: .topLeading, endPoint: .bottom))
                .frame(width: 175, height: 150)
            
            VStack {
                Image(image)
                
                Text(text)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.top, 10)
            }
        }.shadow(color: .gray.opacity(0.2), radius: 10, y: 10)
        
    }
}
