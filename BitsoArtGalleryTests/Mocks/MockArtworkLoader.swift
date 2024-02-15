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
    var artworkDetail: ArtworkDetail = ArtworkDetail(id: 123,
                                                     title: "Some art",
                                                     artistDisplay: "John Doe",
                                                     dateDisplay: "2022",
                                                     mediumDisplay: "Oil on canvas",
                                                     dimensions: "50 x 50 cm",
                                                     description: "This is a beautiful artwork created by John Doe.",
                                                     imageId: "image_123",
                                                     inscriptions: "Signed by the artist.",
                                                     creditLine: "Gift of John Doe",
                                                     galleryTitle: "Gallery 1",
                                                     departmentTitle: "Modern Art")
    
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        return ArtworkList(pagination: Pagination(total: artworks.count, totalPages: totalPages), data: artworks)
    }
    
    func fetchArtworkDetail(withId id: Int) async throws -> ArtworkDetailResponse {
        if artworkDetail.id == id {
            return ArtworkDetailResponse(data: artworkDetail)
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
