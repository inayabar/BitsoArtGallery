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
            AsyncImage(
                url: URL(string: "https://www.artic.edu/iiif/2/\(artwork.imageId)/full/843,/0/default.jpg"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 120, maxHeight: 120)
                },
                placeholder: {
                    ProgressView()
                        .frame(width: 120, height: 120)
                }
            )
            
            VStack(alignment:.leading) {
                Text(artwork.title)
                    .font(.headline)
                    .bold()
                
                Text(artwork.artistTitle)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ArtworkCard(artwork: Artwork(id: 123, title: "Starry night and the astronauts", artistTitle: "Alma Thomas", departmentTitle: "Contemporary art", imageId: "e966799b-97ee-1cc6-bd2f-a94b4b8bb8f9", thumbnail: nil))
}
