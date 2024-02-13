//
//  ArtworkDetail.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import Foundation
struct ArtworkDetailResponse: Decodable {
    let data: ArtworkDetail
}

struct ArtworkDetail: Decodable {
    let id: Int
    let title: String
    let artistTitle: String?
    let departmentTitle: String?
    let imageId: String?
    let description: String?
    let artistDisplay: String?
    let dimensions: String?
    let mediumDisplay: String?
}
