//
//  ArtworkListViewModel.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

public enum PagingState {
    case idle
    case loading
    case error(error: Error)
}

@MainActor
class ArtworkListViewModel: ObservableObject {
    private let artworkLoader: ArtworkLoader
    private let itemsFromEndThreshold = 12
    private var totalArtworks: Int = 0
    private var page = 0
    
    @Published var artworks: [Artwork] = []
    @Published var isLoading = false
    @Published var pagingState: PagingState = .idle
    
    init(artworkLoader: ArtworkLoader) {
        self.artworkLoader = artworkLoader
    }
    
    func loadInitialArtworks() async throws {
        try await loadArtworks(page: 1)
    }
    
    func requestMoreItemsIfNeeded(for index: Int) async throws {
        if scrollingThresholdMet(at: index) && moreArtworksRemaining() {
            let nextPage = page + 1
            try await loadArtworks(page: nextPage)
        }
    }
    
    func refresh() async {
        artworks = []
        page = 0
        try! await loadInitialArtworks()
    }
    
    private func loadArtworks(page: Int) async throws {
        // TODO: Handle errors
        self.pagingState = .loading
        let response = try await artworkLoader.fetchArtworks(page: page)
        self.page += 1
        self.artworks += response.data
        self.totalArtworks = response.pagination.total
        self.pagingState = .idle
    }
    
    private func scrollingThresholdMet(at index: Int) -> Bool {
        return (artworks.count - index) == itemsFromEndThreshold
    }
    
    private func moreArtworksRemaining() -> Bool {
        return artworks.count < totalArtworks
    }
}
