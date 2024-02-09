//
//  Resource.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation

struct Resource<T: Decodable> {
    let request: URLRequest
    let responseType: T.Type
}
