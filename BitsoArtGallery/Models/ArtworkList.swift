//
//  ArtworkList.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation

struct ArtworkList: Codable {
    let pagination: Pagination
    let data: [Artwork]
}

struct Pagination: Codable {
    let total: Int
    let totalPages: Int
}


