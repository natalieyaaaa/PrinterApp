//
//  ScrollDocsView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 06.04.2024.
//

import SwiftUI

struct ScrollDocsView: View {
    
    @EnvironmentObject var dvm: DocsViewModel
    @EnvironmentObject var pvm: PrinterViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var selection: Int = 0
    @State var shareImage: PickedImage?

    @State var name = ""
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy, hh:mm"
        return formatter}()
    
    var body: some View {
        VStack {
            HStack {
                Button{dismiss()} label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                        .font(.title3)
                }
                
                Text("Documents")
                    .font(Font.title2.weight(.semibold))
                    .frame(maxWidth: 300)
                
                Button {
                    if let imageData = dvm.docs[selection].image {
                         pvm.imagesPrint.append(UIImage(data: imageData)!)
                         pvm.printImages()
                     }
                    pvm.printImages()
                } label: {
                    Image(systemName: "printer")
                        .font(Font.system(size: 24))
                }
                
            }.padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color.white.ignoresSafeArea())
            
            if !dvm.docs.isEmpty {
                TabView(selection: $selection) {
                    ForEach(dvm.docs.indices, id: \.self) { index in
                        
                        VStack(spacing: 10) {
                            Text(dvm.docs[index].name!)
                                .padding(10)
                                .font(Font.system(size: 15))
                                .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.white))
                            
                            Image(uiImage: UIImage(data: dvm.docs[index].image!)!)
                                .resizable()
                                .frame(width: 300, height: 200)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.white))
                                .shadow(color: .gray.opacity(0.3), radius: 5)
                                .tag(index)
                        }
                    }
                }.tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
            } else {
                Spacer()
                Text("No documents yet")
                    .font(Font.title2)
                Spacer()
            }
            
            Spacer()

            
            HStack {
                Button {
                    dvm.showDeleteDoc = true
                } label: {
                    HStack {
                            Image(systemName: "trash")
                                .renderingMode(.template)
                                .foregroundStyle(.blue)
                            Text("Delete")
                                .font(Font.headline.weight(.semibold))
                    }
                } .padding(.horizontal)
                
                Spacer()
                
                Button {
                    shareImage = PickedImage(image: UIImage(data: dvm.docs[selection].image!)!)
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.template)
                            .foregroundStyle(.blue)
                        Text("Share")
                            .font(Font.headline.weight(.semibold))
                    }
                }
                
                Spacer()
                
                Button {
                    dvm.showChangeName = true
                } label: {
                    HStack {
                            Image(systemName: "pencil.line")
                                .renderingMode(.template)
                                .foregroundStyle(.blue)
                            Text("Rename")
                                .font(Font.headline.weight(.semibold))
                    }
                }
                
            }.padding(.top, 20)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.white.ignoresSafeArea())
            
        } .onAppear {
            dvm.getDocs()
        }
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
        
        .sheet(item: $shareImage) { image in
            ActivityViewController(itemsToShare: [image.image.jpegData(compressionQuality: 1.0)!])
        }
        
        .alert("Are you sure you want to delete this?", isPresented: $dvm.showDeleteDoc) {
            Button("Yes", action: {
                withAnimation {
                    dvm.deleteDoc(entity: dvm.docs[selection])
                    selection -= 1
                }
            })
            Button("No", role: .cancel) {}
        }
        
        .alert("Rename document", isPresented: $dvm.showChangeName) {
            TextField("Type new name...", text: $dvm.newDocName)
            Button("OK", action: {
                withAnimation{dvm.renameDoc(entity: dvm.docs[selection])}})
                
            Button("Cancel", role: .cancel) {}
        }
    }
}


#Preview {
    ScrollDocsView()
        .environmentObject(DocsViewModel())
        .environmentObject(PrinterViewModel())
}

