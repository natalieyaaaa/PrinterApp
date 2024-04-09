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
    
    @State var showChangeName = false
    @State var showDeleteDoc = false
    @State var newDocName = ""
    @State var currentDoc: Document?
    
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
                        alignment: .center,
                        spacing: 16
                    ) {
                        ForEach(dvm.docs, id: \.id) { doc in
                            
                            VStack(alignment: .leading) {
                                Image(uiImage: UIImage(data: doc.image!)!)
                                    .resizable()
                                    .frame(width: 150, height: 100)
                                
                                Text(doc.name!)
                                    .font(Font.headline.weight(.semibold))
                                    .foregroundStyle(.black)
                                    .frame(width: 150)
                                    .lineLimit(1)
                                
                                HStack {
                                    Text(dateFormatter.string(from: doc.timeTaken!))
                                        .font(Font.system(size: 12))
                                        .foregroundStyle(.gray)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                    
                                    Menu {
                                        
                                        Button{
                                            pvm.imagesPrint.append(UIImage(data: doc.image!)!)
                                            pvm.printImages()
                                        } label: {
                                            Text("Print")
                                            Spacer()
                                            Image(systemName: "printer")
                                        }.frame(width: 80)
                                        
                                        Button {
                                            currentDoc = doc
                                            showChangeName = true
                                        } label: {
                                            Text("Rename")
                                            Spacer()
                                            Image(systemName: "pencil.line")
                                        }
                                        
                                        Button {
                                            currentDoc = doc
                                            showDeleteDoc = true
                                        } label: {
                                            Text("Delete")
                                            Spacer()
                                            Image(systemName: "trash")
                                        }
                                        
                                    } label: {
                                        Image(systemName: "list.bullet.circle.fill")
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                    
                                    
                                    
                                }.frame(width: 150)
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
        
            .alert("Rename document", isPresented: $showChangeName) {
                TextField("Type new name...", text: $newDocName)
                Button("OK", action: {
                    guard currentDoc != nil else {return}
                    currentDoc!.name = newDocName
                    dvm.coreData.updateEntity()
                    newDocName = ""})
                Button("Cancel", role: .cancel) {}
            }
            .alert("Are you sure you want to delete this?", isPresented: $showDeleteDoc) {
                Button("Yes", action: {
                    guard currentDoc != nil else {return}
                    dvm.coreData.deleteEntity(entity: currentDoc!)
                    dvm.getDocs()})
                Button("No", role: .cancel) {}
            }
    }
}

#Preview {
    PrintDocumentsView()
        .environmentObject(PrinterViewModel())
}
