//
//  ViewModelFactory.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import Foundation

class ViewModelFactory: ObservableObject {
    let artworkLoader = ArtworkService()
    
    @MainActor 
    func makeArtworkListViewModel() -> ArtworkListViewModel {
        return ArtworkListViewModel(artworkLoader: artworkLoader)
    }
    
    @MainActor
    func makeArtworkDetailViewModel(for id: Int) -> ArtworkDetailViewModel {
        return ArtworkDetailViewModel(artworkLoader: artworkLoader, artworkId: id)
    }
}
