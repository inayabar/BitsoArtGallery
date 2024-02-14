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
    let artistDisplay: String
    let dateDisplay: String
    let mediumDisplay: String
    let dimensions: String
    let description: String?
    let imageId: String?
    let inscriptions: String?
    let creditLine: String
    let publicationHistory: String?
    let exhibitionHistory: String?
    let provenanceText: String?
    let galleryTitle: String?
    let departmentTitle: String
}
