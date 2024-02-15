//
//  ArtworkCard.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import SwiftUI

struct ArtworkCard: View {
   var artwork: Artwork
    
    var body: some View {
        HStack(alignment: .top) {
            if let imageId = artwork.imageId, let imageUrl = APIs.Artic.getImage(id: imageId).url {
                AsyncCachableImage(url: imageUrl, placeholder: "ArtworkPlaceholder")
                    .frame(width: 120, height: 120, alignment: .top)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
            } else {
                Image("ArtworkPlaceholder")
                    .resizable()
                    .frame(width:120, height:120, alignment: .center)
                    .clipped()
            }
            
            VStack(alignment:.leading) {
                Text(artwork.title)
                    .font(.headline)
                    .bold()
                Text(artwork.artistTitle ?? "Unknown Artist")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ArtworkCard(artwork: Artwork(id: 123, title: "Starry night and the astronauts", artistTitle: "Alma Thomas", departmentTitle: "Contemporary art", imageId: "5b23cb0f-ea53-81ac-0eda-ba07833fddd1"))
}

#Preview {
    ArtworkCard(artwork: Artwork(id: 123, title: "Starry night and the astronauts", artistTitle: "Alma Thomas", departmentTitle: "Contemporary art", imageId: nil))
}
