//
//  PrintWebView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 03.04.2024.
//

import SwiftUI
import WebKit

struct PrintWebView: View {
    
    @EnvironmentObject var pvm: PrinterViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var inputURL = ""
    @State var showedURL = "https://www.google.com/"

    
    @State var showAlert = false
    
    let webView = WebView()
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
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
                }.background(RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.gray.opacity(0.2))
                    .shadow(color: .gray.opacity(0.5), radius: 13, y: 8))
                
                Spacer()
                
                Button {
                   printWebPage()
                } label: {
                    Image(systemName: "printer")
                        .font(Font.system(size: 24))
                }.padding(.trailing, 20)
                
            }
            
            Divider()
            
            HStack {
                CustomURLTextField(input: $inputURL)
                    .padding(.leading, 10)
                
                Spacer()
                
                Button {
                    hideKeyboard()
                    guard inputURL != "" else {showAlert = true; return}
                    if !inputURL.contains("https://") {
                        showedURL = generateGoogleSearchLink(query: inputURL)
                    } else {
                        showedURL = inputURL
                    }
                    webView.loadURL(urlString: showedURL)
                    
                } label: {
                    Text("Search")
                }.padding(.trailing, 25)
            }
            
            Divider()
            
            webView
                .ignoresSafeArea()
                .onAppear {
                    webView.loadURL(urlString: showedURL)
                }
        }.onDisappear {
            inputURL = ""
        }
        
    }
    
    func generateGoogleSearchLink(query: String) -> String {
        let formattedQuery = query.replacingOccurrences(of: " ", with: "+")
        let link = "https://www.google.com/search?q=\(formattedQuery)"
        return link
    }
    
    func printWebPage() {
        
        guard showedURL != "" else { return }
        
            webView.loadURL(urlString: showedURL)
            
            guard UIPrintInteractionController.isPrintingAvailable else {
                print("Принтер недоступен")
                return
            }
        
        // Получаем viewPrintFormatter из webView
        let printFormatter = webView.webView.viewPrintFormatter()
        
        // Создаем контроллер для печати
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        printInfo.jobName = "Печать веб-страницы"
        
        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.showsNumberOfCopies = false
        
        // Устанавливаем содержимое для печати
        printController.printFormatter = printFormatter
        
        // Отображаем контроллер для печати
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Ошибка при печати: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    PrintWebView()
}

 struct WebView: UIViewRepresentable, Observable {
    
    let webView: WKWebView
    
    init() {
        self.webView = WKWebView()
        
    }
    
     func makeUIView(context: Context) -> WKWebView {
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
    
     func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func goBack(){
        webView.goBack()
    }
    
    func goForward(){
        webView.goForward()
    }
    
    
    func loadURL(urlString: String) {
        webView.load(URLRequest(url: URL(string: urlString)!))
    }
}

struct CustomURLTextField: View {
    @Binding var input: String
    var body: some View {
        
        HStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.gray.opacity(0.2))
                .frame(width: 280, height: 40)
                .overlay {
                    HStack(spacing: 0) {
                        TextField("Type in URL...", text: $input)
                            .padding()
                            .frame(width: 260)
                        
                        if input != "" {
                            Button {
                                input = ""
                            }label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                                    .padding(4)
                                    .background(Circle().foregroundStyle(.white))
                                    .padding(.trailing)
                            }
                        } else {
                            Spacer()
                        }
                    }.frame(maxWidth: 280)
                }
        }
    }
} 
