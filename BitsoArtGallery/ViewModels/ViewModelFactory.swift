//
//  ViewModelFactory.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import Foundation

class ViewModelFactory: ObservableObject {
    var artworkLoader: ArtworkLoader {
        if CommandLine.arguments.contains("-UITests") {
            // Running UI test, should inject fake service
            return MockArtworkLoader()
        } else {
            return ArtworkService(networkingService: NetworkService(), fileManager: FileManager.default)
        }
    }
    
    @MainActor 
    func makeArtworkListViewModel() -> ArtworkListViewModel {
        return ArtworkListViewModel(artworkLoader: artworkLoader)
    }
    
    @MainActor
    func makeArtworkDetailViewModel(for artwork: Artwork) -> ArtworkDetailViewModel {
        return ArtworkDetailViewModel(artworkLoader: artworkLoader, artwork: artwork)
    }
}
