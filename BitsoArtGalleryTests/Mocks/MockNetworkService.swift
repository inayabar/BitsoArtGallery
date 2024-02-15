//
//  MockNetworkService.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation

class MockNetworkService: NetworkResourceLoader {
    let defaultResponse: Any
    
    init(defaultResponse: Any) {
        self.defaultResponse = defaultResponse
    }
    
    func load<T>(resource: Resource<T>) async throws -> T where T : Decodable {
        guard let mockData = defaultResponse as? T else {
            throw NetworkError.invalidUrlError
        }
        return mockData
    }
}

class OfflineNetworkService: NetworkResourceLoader {
    func load<T>(resource: Resource<T>) async throws -> T where T : Decodable {
        throw NetworkError.notConnectedToInternet
    }
}
