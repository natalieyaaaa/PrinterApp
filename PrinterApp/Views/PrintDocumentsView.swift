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
    
    @State var selected = 0
    
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
                    Spacer()
                    Text("No documents yet")
                        .font(Font.title2)
                    Spacer()
                    
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(150), spacing: 50),
                            GridItem(.fixed(150), spacing: 50),
                        ],
                        alignment: .center,
                        spacing: 16
                    ) {
                        ForEach(dvm.docs.indices, id: \.self) { index in
                            NavigationLink {
                                ScrollDocsView(selection: index)
                                    .environmentObject(dvm)
                                    .environmentObject(pvm)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                VStack(alignment: .leading) {
                                    Image(uiImage: UIImage(data: dvm.docs[index].image!)!)
                                        .resizable()
                                        .frame(width: 150, height: 100)
                                    
                                    Text(dvm.docs[index].name!)
                                        .font(Font.headline.weight(.semibold))
                                        .foregroundStyle(.black)
                                        .frame(width: 150)
                                        .lineLimit(1)
                                    
                                    HStack {
                                        Text(dateFormatter.string(from: dvm.docs[index].timeTaken!))
                                            .font(Font.system(size: 12))
                                            .foregroundStyle(.gray)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                        
                                    }.frame(width: 150)
                                }.padding(10)
                                    .background(RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(.white))
                                    .shadow(color: .gray.opacity(0.3), radius: 5)
                                
                            } .overlay(alignment: .bottomTrailing) {
                                VStack {
                                    Menu {
                                        
                                        Button{
                                            pvm.imagesPrint.append(UIImage(data: dvm.docs[index].image!)!)
                                            pvm.printImages()
                                        } label: {
                                            Text("Print")
                                            Spacer()
                                            Image(systemName: "printer")
                                        }.frame(width: 80)
                                        
                                        Button {
                                            selected = index
                                            dvm.showChangeName = true
                                        } label: {
                                            Text("Rename")
                                            Spacer()
                                            Image(systemName: "pencil.line")
                                        }
                                        
                                        Button {
                                            selected = index
                                            dvm.showDeleteDoc = true
                                        } label: {
                                            Text("Delete")
                                            Spacer()
                                            Image(systemName: "trash")
                                        }
                                    } label: {
                                        Image(systemName: "list.bullet.circle.fill")
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                }.padding(5)
                            }

                        }
                    }.frame(maxWidth: .infinity)
                    
                }
                
                Spacer()
                
            }.background(Color.gray.opacity(0.1).ignoresSafeArea())
            
        } .onAppear {dvm.getDocs()}
        
            .alert("Rename document", isPresented: $dvm.showChangeName) {
                TextField("Type new name...", text: $dvm.newDocName)
                Button("OK", action: {dvm.renameDoc(entity: dvm.docs[selected])})
                Button("Cancel", role: .cancel) {}
            }
        
            .alert("Are you sure you want to delete this?", isPresented: $dvm.showDeleteDoc) {
                Button("Yes", action: {dvm.deleteDoc(entity: dvm.docs[selected])})
                Button("No", role: .cancel) {}
            }
    }
}

//#Preview {
//    PrintDocumentsView()
//        .environmentObject(PrinterViewModel())
//}
