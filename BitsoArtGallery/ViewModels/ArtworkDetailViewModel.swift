//
//  ArtworkDetailViewModel.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import Foundation

@MainActor
class ArtworkDetailViewModel: ObservableObject {
    private let artworkLoader: ArtworkLoader
    private var artworkId: Int
    
    init(artworkLoader: ArtworkLoader, artworkId: Int) {
        self.artworkLoader = artworkLoader
        self.artworkId = artworkId
    }
    
}
