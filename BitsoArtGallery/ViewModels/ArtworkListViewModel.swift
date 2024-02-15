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
}

@MainActor
class ArtworkListViewModel: ObservableObject {
    private let artworkLoader: ArtworkLoader
    private let itemsFromEndThreshold = 12
    internal var totalArtworks: Int = 0
    private var page = 0
    private var artworkSet: Set<Artwork> = Set()
    
    @Published var artworks: [Artwork] = []
    @Published var isLoading = false
    @Published var pagingState: PagingState = .idle
    @Published var isShowingError: Bool = false
    @Published var errorMessage = ""
    
    init(artworkLoader: ArtworkLoader) {
        self.artworkLoader = artworkLoader
    }
    
    func loadInitialArtworks() async {
        await loadArtworks(page: 1)
    }
    
    func requestMoreItemsIfNeeded(for index: Int) async {
        if scrollingThresholdMet(at: index) && moreArtworksRemaining() {
            let nextPage = page + 1
            await loadArtworks(page: nextPage)
        }
    }
    
    func refresh() async {
        artworks = []
        artworkSet.removeAll()
        page = 0
        await loadInitialArtworks()
    }
    
    private func loadArtworks(page: Int) async {
        do {
            self.pagingState = .loading
            let response = try await artworkLoader.fetchArtworks(page: page)
            self.page += 1
            
            response.data.forEach { artwork in
                if !artworkSet.contains(artwork) {
                    artworks.append(artwork)
                    artworkSet.insert(artwork)
                }
            }
            
            self.totalArtworks = response.pagination.total
            self.pagingState = .idle
            self.isShowingError = false
        } catch {
            self.isShowingError = true
            if let error = error as? ArtworkLoaderError {
                self.errorMessage = error.rawValue
            } else {
                self.errorMessage = "Oh no! Could not load more artworks. Please try again later"
            }
        }
    }
    
    private func scrollingThresholdMet(at index: Int) -> Bool {
        return (artworks.count - index) == itemsFromEndThreshold
    }
    
    private func moreArtworksRemaining() -> Bool {
        return artworks.count < totalArtworks
    }
}
