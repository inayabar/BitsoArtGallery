//
//  MockArtworks.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
class MockArtworks {
    static let artworkWithImage = Artwork(id: 123, title: "Some art", artistTitle: "John Doe", departmentTitle: "Contemporary", imageId: "123-456")
    static let artworkWithoutImage = Artwork(id: 456, title: "Some art", artistTitle: "John Doe", departmentTitle: "Contemporary", imageId: nil)
    static let artworkList = ArtworkList(pagination: Pagination(total: 1, totalPages: 1), data: [artworkWithImage])
    
    static let artworkDetail: ArtworkDetail = ArtworkDetail(id: 123,
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
    static let artworkDetailResponse = ArtworkDetailResponse(data: artworkDetail)
}
