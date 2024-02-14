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
    
    static let fields = ["id", "title", "artist_display", "date_display", "medium_display", "dimensions", "description", "image_id", "inscriptions", "credit_line", "publication_history", "exhibition_history", "provenance_text", "gallery_title", "department_title"]
}
