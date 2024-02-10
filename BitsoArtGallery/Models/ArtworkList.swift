//
//  ArtworkList.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation

struct ArtworkList: Decodable {
    let pagination: Pagination
    let data: [Artwork]
    let config: Config
}

struct Pagination: Decodable {
    let total: Int
    let totalPages: Int
}

struct Config: Decodable {
    let iiifUrl: String
}
