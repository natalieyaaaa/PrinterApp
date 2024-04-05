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
    
    private var columns: [GridItem] = [
          GridItem(.fixed(150), spacing: 50),
          GridItem(.fixed(150), spacing: 50),
      ]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy, hh:mm"
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
                    .padding(.bottom, 10)
                    .background(Color.white.ignoresSafeArea())
                                
                if dvm.docs.isEmpty {
                    Text("no docs")
                } else {
                    LazyVGrid(
                    columns: columns,
                    alignment: .center
                ) {
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
                                
                                HStack {
                                    Text(dateFormatter.string(from: doc.timeTaken!))
                                        .font(Font.system(size: 12))
                                        .foregroundStyle(.gray)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                    
                                    NavigationLink{} label: {
                                        Image(systemName: "list.bullet.circle.fill")
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                    
                                }.frame(maxWidth: 150)
                            }.padding(10)
                            .background(RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.white))
                            .shadow(color: .gray.opacity(0.3), radius: 5)
                        }
                    }.frame(maxWidth: .infinity)
                    
                }
                Spacer()
            }.background(Color.gray.opacity(0.1).ignoresSafeArea())
            
        } .onAppear {dvm.getDocs()}
    }
}

#Preview {
    PrintDocumentsView()
        .environmentObject(PrinterViewModel())
}
