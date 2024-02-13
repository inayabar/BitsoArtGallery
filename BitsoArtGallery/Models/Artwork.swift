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
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
    let width: Int
    let height: Int
    
    var aspectRatio: Float {
        return Float(width)/Float(height)
    }
}
