//
//  PrintWebView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 03.04.2024.
//

import SwiftUI

struct PrintWebView: View {
    
    @EnvironmentObject var pvm: PrinterViewModel
    @EnvironmentObject var wvm: WebViewModel
    
    @Environment(\.dismiss) var dismiss
            
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                        .font(.title3)
                }.padding(.horizontal, 20)
                
                HStack {
                    Image("web")
                        .padding(10)
                    
                    Text("Print a Web Page")
                        .font(Font.title3.weight(.semibold))
                        .foregroundStyle(.black.opacity(0.8))
                        .padding(.trailing)
                }.background(RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.gray.opacity(0.2))
                    .shadow(color: .gray.opacity(0.5), radius: 13, y: 8))
                
                Spacer()
                
                Button {
                    pvm.printWebPage()
                } label: {
                    Image(systemName: "printer")
                        .font(Font.system(size: 24))
                }.padding(.trailing, 20)
                
            }
            
            Divider()
            
            HStack {
                CustomURLTextField(input: $wvm.inputURL)
                    .padding(.leading, 10)
                
                Spacer()
                
                Button {
                    wvm.searchButton()
                } label: {
                    Text("Search")
                }.padding(.trailing, 25)
            }
            
            Divider()
            
            wvm.webView
                .ignoresSafeArea()
                .onAppear {
                    wvm.webView.loadURL(urlString: wvm.showedURL)
                }
        }.onDisappear {
            wvm.inputURL = ""
            wvm.showedURL = "https://www.google.com/"
        }
        
        .alert("Type in something to search", isPresented: $wvm.showAlert) {
            Button("Ok", role: .cancel, action: {})
        }    }
    
}

#Preview {
    PrintWebView()
        .environmentObject(PrinterViewModel())
        .environmentObject(WebViewModel())
}

