//
//  NetworkingManager.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

class ArtworkService {
    let networkingService: NetworkService = NetworkService()
    
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        guard let url = APIs.Artic.getArtworks(page: 1).url else {
            throw NetworkError.invalidUrlError
        }
        
        let resource = Resource.init(request: URLRequest(url: url), responseType: ArtworkList.self)
        
        // TODO: Handle success case (Save file) and failure case (Use saved data)
        return try await networkingService.load(resource: resource)
    }
}
