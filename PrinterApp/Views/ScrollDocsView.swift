//
//  ScrollDocsView.swift
//  PrinterApp
//
//  Created by Наташа Яковчук on 06.04.2024.
//

import SwiftUI

struct ScrollDocsView: View {
    @EnvironmentObject var dvm: DocsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var currentIndex = 0

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy, hh:mm"
        return formatter}()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
            }

            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    LazyHStack(spacing: 20) {
                        ForEach(dvm.docs, id: \.id) { doc in
                            GeometryReader { geometry in
                                
                                VStack(alignment: .leading) {
                                    Image(uiImage: UIImage(data: doc.image!)!)
                                        .resizable()
                                        .frame(width: 300, height: 200)
                                    
                                    
                                    Text(doc.name!)
                                        .font(Font.headline.weight(.semibold))
                                        .foregroundStyle(.black)
                                        .frame(width: 300)
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
                                        
                                    }.frame(width: 300)
                                }
                                                   .frame(width: 300, height: 250) // Set a fixed size
                                                   .padding(10)
                                                   .background(RoundedRectangle(cornerRadius: 15)
                                                       .foregroundStyle(.white))
                                                   .shadow(color: .gray.opacity(0.3), radius: 5)
                                                   .onAppear {
                                                       // Check if the current item is the last visible one
                                                       let offsetX = geometry.frame(in: .global).minX
                                                       let scrollViewWidth = UIScreen.main.bounds.width
                                                       let threshold: CGFloat = 100 // Adjust threshold as needed
                                                       if offsetX >= scrollViewWidth - threshold {
                                                           if let currentIndex = dvm.docs.firstIndex(where: { $0.id == doc.id }) {
                                                               // Scroll to the next item
                                                               withAnimation {
                                                                   proxy.scrollTo(dvm.docs[(currentIndex + 1)], anchor: .center)
                                                               }
                                                           }
                                                       }
                                                   }
                                               }
                                               .frame(width: 300, height: 250) // Set a fixed size for GeometryReader
                                           }
                                       }
                                   }
                               }    } .onAppear {
                dvm.getDocs()
            }
        }
    }


#Preview {
    ScrollDocsView()
        .environmentObject(DocsViewModel())
}
