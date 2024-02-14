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
    
    @Published var artwork: ArtworkDetail? = nil
    
    init(artworkLoader: ArtworkLoader, artworkId: Int) {
        self.artworkLoader = artworkLoader
        self.artworkId = artworkId
    }
    
    func loadArtwork() async throws {
        let response = try await self.artworkLoader.fetchArtworkDetail(withId: artworkId)
        self.artwork = response?.data
    }
    
    func getImageURL() -> URL? {
        guard let id = artwork?.imageId else {
            return nil
        }
        
         return APIs.Artic.getImage(id: id).url
    }
}
