//
//  NetworkingManager.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

class NetworkManager {
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        guard let url = URL(string: "https://api.artic.edu/api/v1/artworks?page=\(page)") else {
            print("Invalid URL")
            throw NetworkError.invalidUrlError
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(ArtworkList.self, from: data)
    }
}
