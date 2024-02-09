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
    private let networkManager: ArtworkService
    private let itemsFromEndThreshold = 3
    private var totalArtworks: Int = 0
    private var page = 0
    
    @Published var artworks: [Artwork] = []
    @Published var isLoading = false
    @Published var pagingState: PagingState = .idle
    
    init(networkManager: ArtworkService) {
        self.networkManager = networkManager
    }
    
    private var moreArtworksRemaining: Bool {
        return artworks.count < totalArtworks
    }
    
    func loadInitialArtworks() async throws {
        try await loadArtworks(page: 1)
    }
    
    func requestMoreItemsIfNeeded(for index: Int) async throws {
        if scrollingThresholdMet(at: index) && moreArtworksRemaining {
            page += 1
            print("fetching page \(page)")
            try await loadArtworks(page: page)
        }
    }
    
    func refresh() async {
        artworks = []
        try! await loadInitialArtworks()
    }
    
    private func loadArtworks(page: Int) async throws {
        self.pagingState = .loading
        let response = try await networkManager.fetchArtworks(page: page)
        self.artworks += response.data
        self.totalArtworks = response.pagination.total
        self.page += 1
        self.pagingState = .idle
    }
    
    private func scrollingThresholdMet(at index: Int) -> Bool {
        return (artworks.count - index) == itemsFromEndThreshold
    }
}
