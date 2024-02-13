//
//  ArtworkDetaiView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import SwiftUI

struct ArtworkDetaiView: View {
    @StateObject var viewModel: ArtworkDetailViewModel
    
    var body: some View {
        VStack {
            if let imageId = viewModel.artwork?.imageId, let imageUrl = APIs.Artic.getImage(id: imageId).url{
                AsyncCachableImage(url: imageUrl, placeholder: "ArtworkPlaceholder")
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 400)
            } else {
                Image("ArtworkPlaceholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .onAppear {
            Task {
                try! await viewModel.loadArtwork()
            }
        }
    }
}

#Preview {
    ArtworkDetaiView(viewModel: ArtworkDetailViewModel(artworkLoader: ArtworkService(), artworkId: 123))
}
