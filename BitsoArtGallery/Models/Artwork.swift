//
//  Artwork.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

struct Artwork {
    let id: Int
    let title: String
    let description: String
    let dimensions: String
    let mediumDisplay: String
    let artistTitle: String
    let departmentTitle: String
    let imageId: String
    let thumbnai: Thumbnail
}

struct Thumbnail {
    let width: Int
    let height: Int
    
    var aspectRatio: Float {
        return Float(width)/Float(height)
    }
}
