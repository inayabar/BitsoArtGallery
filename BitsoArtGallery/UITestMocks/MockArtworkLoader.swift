//
//  MockArtworkLoader.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
class MockArtworkLoader: ArtworkLoader {
    static let artworks = [
        Artwork(id: 1, title: "Artwork 1", artistTitle: "John Doe", departmentTitle: nil, imageId: nil),
        Artwork(id: 2, title: "Artwork 2", artistTitle: "Jane Smith", departmentTitle: "Modern Art", imageId: "aa8a9d42-ed14-6cd9-68b1-f2f6d1bf04b2"),
        Artwork(id: 3, title: "Artwork 3", artistTitle: "David Johnson", departmentTitle: "Contemporary Art", imageId: "7a7e00b7-b0ad-17bb-fd4e-f247b8eccb9e"),
        Artwork(id: 4, title: "Artwork 4", artistTitle: "Emily Brown", departmentTitle: "Sculpture", imageId: nil),
        Artwork(id: 5, title: "Artwork 5", artistTitle: "Michael Wilson", departmentTitle: "Photography", imageId: nil)
    ]

    func fetchArtworks(page: Int) async throws -> ArtworkList {
        return ArtworkList(pagination: Pagination(total: 20, totalPages: 2),
                           data: MockArtworkLoader.artworks)
    }
    
    func fetchArtworkDetail(withId: Int) async throws -> ArtworkDetailResponse {
        throw ArtworkLoaderError.couldNotLoadArtwork
    }
}
