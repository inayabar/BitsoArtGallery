//
//  Artwork.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

struct Artwork: Identifiable, Decodable {
    let id: Int
    let title: String
    let artistTitle: String?
    let departmentTitle: String?
    let imageId: String?
    
    static let fields = ["id", "title", "artist_title", "department_title", "image_id"]
}
