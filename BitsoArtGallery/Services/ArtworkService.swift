//
//  NetworkingManager.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

protocol ArtworkLoader {
    func fetchArtworks(page: Int) async throws -> ArtworkList
    func fetchArtworkDetail(withId: Int) async throws -> ArtworkDetailResponse?
}

class ArtworkService: ArtworkLoader {
    let networkingService: NetworkService = NetworkService()
    
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        guard let url = APIs.Artic.getArtworks(page: page).url else {
            throw NetworkError.invalidUrlError
        }
        
        let resource = Resource.init(request: URLRequest(url: url), responseType: ArtworkList.self)
        
        // TODO: Handle success case (Save file) and failure case (Use saved data)
        return try await networkingService.load(resource: resource)
    }
    
    func fetchArtworkDetail(withId id: Int) async throws -> ArtworkDetailResponse? {
        guard let url = APIs.Artic.getArtwork(id: id).url else {
            throw NetworkError.invalidUrlError
        }
        
        let resource = Resource.init(request: URLRequest(url: url), responseType: ArtworkDetailResponse.self)
        
        // TODO: Handle success case (Save file) and failure case (Use saved data)
        return try await networkingService.load(resource: resource)
    }
}
