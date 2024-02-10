//
//  APIs.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation

enum APIs {
    enum Artic {
        case getArtworks(page: Int)
        case getImage(id: String)
        
        var baseURL: String {
            switch self {
            case .getArtworks(let page):
                return "https://api.artic.edu/api/v1/artworks?page=\(page)"
            case .getImage(let id):
                return "https://www.artic.edu/iiif/2/\(id)/full/843,/0/default.jpg"
            }
        }
        
        var url: URL? {
            URL(string: baseURL)
        }
    }
}
