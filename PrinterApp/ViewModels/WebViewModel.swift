//
//  PrintWebViewModel.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 04.04.2024.
//

import Foundation
import WebKit
import SwiftUI

class WebViewModel: ObservableObject {
    
    @Published var inputURL = ""
    @Published var showedURL = "https://www.google.com/"
    @Published var showAlert = false

    let webView = WebView()
    
    static let shared = WebViewModel()
    init() {}
    
    func searchButton() {
        hideKeyboard()
        guard inputURL != "" else {showAlert = true; return}
        if !inputURL.contains("https://") {
            showedURL = generateGoogleSearchLink(query: inputURL)
        } else {
            showedURL = inputURL
        }
        webView.loadURL(urlString: showedURL)
    }
    
    func generateGoogleSearchLink(query: String) -> String {
        let formattedQuery = query.replacingOccurrences(of: " ", with: "+")
        let link = "https://www.google.com/search?q=\(formattedQuery)"
        return link
    }

}

struct WebView: UIViewRepresentable {
   
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
