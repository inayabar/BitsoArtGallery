//
//  NetworkService.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation

protocol NetworkServicing {
    func load<T>(resource: Resource<T>) async throws -> T
}

class NetworkService: NetworkServicing {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func load<T>(resource: Resource<T>) async throws -> T {
        do {
            let (data, response) = try await session.data(for: resource.request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidUrlError
            }

            if !(200..<300 ~= response.statusCode) {
                throw NetworkError.httpError(statusCode: response.statusCode)
            }
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(resource.responseType, from: data)
            
        } catch {
            if let error = error as? NetworkError { throw error }
            
            let error = error as NSError
            if error.domain == NSURLErrorDomain,
               error.code == NSURLErrorNotConnectedToInternet {
                throw NetworkError.notConnectedToInternet
            } else if let _ = error as? DecodingError {
                throw NetworkError.decodingError(error)
            } else {
                throw error
            }
        }
    }
}
