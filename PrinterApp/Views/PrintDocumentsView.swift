//
//  DocumentsView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 04.04.2024.
//

import SwiftUI

struct PrintDocumentsView: View {
    
    @StateObject var dvm = DocsViewModel()
    @EnvironmentObject var pvm: PrinterViewModel
    @Environment(\.dismiss) var dismiss
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy.hh.mm"
        return formatter}()

    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {dismiss()} label: {
                        Image(systemName: "arrow.left")
                            .tint(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                    HStack {
                        Image("email")
                            .padding(10)
                        
                        Text("Print Scanned")
                            .font(Font.title2.weight(.semibold))
                            .foregroundStyle(.black.opacity(0.8))
                            .padding(.trailing)
                    }.background(RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.gray.opacity(0.2))
                        .shadow(color: .gray.opacity(0.5), radius: 13, y: 8))
                    
                    Spacer()
                }.padding(.horizontal)
                                
                if dvm.docs.isEmpty {
                    Text("no docs")
                } else {
                    ScrollView {
                        ForEach(dvm.docs, id: \.id) { doc in
                            
                            VStack(alignment: .leading) {
                                Image(uiImage: UIImage(data: doc.image!)!)
                                    .resizable()
                                    .frame(width: 150, height: 100)
                                
                                Text(doc.name!)
                                    .font(Font.headline.weight(.semibold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: 150)
                                    .lineLimit(1)
                                
                                Text(dateFormatter.string(from: doc.timeTaken!))
                                    .font(Font.system(size: 12))
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: 150)
                                    .lineLimit(1)
                                    
                            }.padding(5)
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.white))
                                .shadow(radius: 5)
                        }
                    }.frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1).ignoresSafeArea())
                }
                Spacer()
            }
            
        } .onAppear {dvm.getDocs()}
    }
}

#Preview {
    PrintDocumentsView()
        .environmentObject(PrinterViewModel())
}
