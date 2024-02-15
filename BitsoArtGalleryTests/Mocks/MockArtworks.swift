//
//  MockArtworks.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
class MockArtworks {
    static let artworkWithImage = Artwork(id: 123, title: "Some art", artistTitle: "John Doe", departmentTitle: "Contemporary", imageId: "123-456")
    static let artworkWithoutImage = Artwork(id: 123, title: "Some art", artistTitle: "John Doe", departmentTitle: "Contemporary", imageId: nil)
    static let artworkList = ArtworkList(pagination: Pagination(total: 1, totalPages: 1), data: [artworkWithImage])
}
