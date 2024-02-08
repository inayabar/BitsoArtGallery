//
//  ArtworkListView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import SwiftUI

struct ArtworkListView: View {
    private var data: [Thumbnail]  = [
        Thumbnail(width: 10242, height: 10278),
        Thumbnail(width: 1405, height: 1125),
        Thumbnail(width: 8588, height: 10000),
        Thumbnail(width: 1673, height: 1291),
        Thumbnail(width: 1409, height: 1033),
        Thumbnail(width: 12588, height: 9441),
        Thumbnail(width: 2724, height: 2250),
        Thumbnail(width: 1350, height: 1800)
    ]
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                    Text(String(index))
                        .frame(width: 150, height: 150*CGFloat(item.aspectRatio), alignment: .center)
                        .background(.blue)
                        //.cornerRadius(10)
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
        }
        .padding()
        .refreshable {
            print("Refreshing")
        }
        
    }
}

#Preview {
    ArtworkListView()
}
