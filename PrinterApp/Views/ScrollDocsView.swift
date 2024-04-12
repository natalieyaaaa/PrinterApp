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
    
    @State var selection = 1
    
    var doc: Document?
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
                
                Text(doc?.name ?? "")
                    .font(Font.title2.weight(.semibold))
                    .frame(maxWidth: 300)
                
                Button {
                    pvm.imagesPrint.append(UIImage(data: doc!.image!)!)
                    pvm.printImages()
                } label: {
                    Image(systemName: "printer")
                        .font(Font.system(size: 24))
                }
                
            }.padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color.white.ignoresSafeArea())
            
            TabView(selection: $selection) {
                ForEach(dvm.docs.indices, id: \.self) { index in
                    Image(uiImage: UIImage(data: dvm.docs[index].image!)!)
                        .resizable()
                        .frame(width: 300, height: 200)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundStyle(.white))
                        .shadow(color: .gray.opacity(0.3), radius: 5)
                        .tag(index)
                        .onAppear {selection = index}
                        
                }
            }.tabViewStyle(.page)
            
            HStack {
                if selection > 1 {
                    Button{
                       
                            selection -= 1
                        } label: {
                        Image(systemName: "arrow.left")
                    }
                }
                Text("\(selection)").font(Font.headline.weight(.semibold))
                if selection < dvm.docs.count {
                    Button{
                        
                            selection += 1
                        } label: {
                        Image(systemName: "arrow.right")
                    }
                }
            }.padding()
                .frame(width: 100)
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.template)
                            .foregroundStyle(.blue)
                            .padding(.trailing)
                        Text("Share")
                            .font(Font.headline.weight(.semibold))
                    }
                }
            }.padding(.horizontal)
                .padding(.top, 10)
                .background(Color.white.ignoresSafeArea())
            
        } .onAppear {
            dvm.getDocs()
        }
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
}


#Preview {
    ScrollDocsView()
        .environmentObject(DocsViewModel())
        .environmentObject(PrinterViewModel())
}

