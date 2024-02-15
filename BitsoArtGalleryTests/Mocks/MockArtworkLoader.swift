//
//  MockArtworkLoader.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
class MockArtworkLoader: ArtworkLoader {
    var artworks: [Artwork] = []
    var totalPages: Int = 1
    
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        return ArtworkList(pagination: Pagination(total: artworks.count, totalPages: totalPages), data: artworks)
    }
    
    func fetchArtworkDetail(withId id: Int) async throws -> ArtworkDetailResponse {
        if MockArtworks.artworkDetail.id == id {
            return MockArtworks.artworkDetailResponse
        }
        throw ArtworkLoaderError.couldNotLoadArtwork
    }
}

struct ThrowingMockArtworkLoader: ArtworkLoader {
    let error: Error
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        throw error
    }
    
    func fetchArtworkDetail(withId: Int) async throws -> ArtworkDetailResponse {
        throw error
    }
}
