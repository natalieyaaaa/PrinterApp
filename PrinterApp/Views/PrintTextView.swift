//
//  PrintTextView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 02.04.2024.
//

import SwiftUI

struct PrintTextView: View {
    
    @EnvironmentObject var pvm: PrinterViewModel
    @FocusState var isFieldFocused
    
    @Environment(\.dismiss) var dismiss
    
    @State var input = ""
    @State var showAlert = false
    
    var body: some View {
        GeometryReader { i in
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .tint(.black)
                            .font(.title3)
                    }.padding(.horizontal, 25)
                    
                    HStack {
                        Image("text")
                            .padding(10)
                        Text("Type and Print")
                            .font(Font.title2.weight(.semibold))
                            .foregroundStyle(.black.opacity(0.8))
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
                
                TextEditor(text: $pvm.textPrint)
                    .focused($isFieldFocused)
                    .overlay {
                        ZStack {
                            if pvm.textPrint == "" {
                                Text("Type in...")
                                    .opacity(0.3)
                                    .padding(.top, 10)
                                    .padding(.leading, 3)
                                    .onTapGesture {
                                        isFieldFocused = true
                                    }
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .frame(width: 360, height: 450)
                    .padding(.horizontal, 22)
                    .padding(.top, 24)
                    .shadow(color: .black.opacity(0.1), radius: 6)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                Button {
                    guard pvm.textPrint != "" else {showAlert = true; return}
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {pvm.printText()}
                    dismiss()
                    
                }label: {
                    Text("Print!")
                        .foregroundStyle(.green)
                        .font(Font.title2.weight(.semibold))
                }.padding()
                    .background(RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.white)
                        .frame(width: 100)
                        .shadow(color: .gray.opacity(0.2), radius: 13, y: 8))
                    .padding(.top, 30)
                
                Spacer()
                
            }.onTapGesture {
                hideKeyboard()
            }
            .alert("Type in something to print", isPresented: $showAlert) {
                Button("Ok", role: .cancel, action: {})
            }
        }.onAppear() {input = ""}
        
    }
}

#Preview {
    PrintTextView()
        .environmentObject(PrinterViewModel())
}
