//
//  ArtworkAdditionalInfoView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 14/02/2024.
//

import SwiftUI

struct ArtworkAdditionalInfoView: View {
    let artwork: ArtworkDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            BoldTitledText(title: "Date", text: artwork.dateDisplay)
            
            BoldTitledText(title: "Department", text: artwork.departmentTitle)
            
            BoldTitledText(title: "Medium", text: artwork.mediumDisplay)
            
            BoldTitledText(title: "Dimensions", text: artwork.dimensions)
            
            if let galleryTitle = artwork.galleryTitle   {
                BoldTitledText(title: "Gallery", text: galleryTitle)
            }
            
            if let inscriptions = artwork.inscriptions {
                BoldTitledText(title: "Inscriptions", text: inscriptions)
            }
            
            if let creditLine = artwork.creditLine  {
                BoldTitledText(title: "Credit Line", text: creditLine)
            }
        }
        .padding()
    }
}

struct BoldTitledText: View {
    var title: String
    var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(title):")
                .font(.subheadline)
                .bold()
            
            Text(text)
                .foregroundColor(.secondary)
        }
    }
}
