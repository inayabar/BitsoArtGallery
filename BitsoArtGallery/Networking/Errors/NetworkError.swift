//
//  NetworkError.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case httpError(statusCode: Int)
    case decodingError(Error)
    case invalidUrlError
    case notConnectedToInternet
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrlError, .invalidUrlError):
            return true
        case let (.httpError(statusCode1), .httpError(statusCode2)):
            return statusCode1 == statusCode2
        case (.notConnectedToInternet, .notConnectedToInternet):
            return true
        case (.decodingError, .decodingError):
            return true
        default:
            return false
        }
    }

}
