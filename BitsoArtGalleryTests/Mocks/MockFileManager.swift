//
//  MockFileManager.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
class MockFileManager: FileManaging {
    var response: Any? = nil
    var writtenData: [String: Any] = [:]
    var readingError: FileManagerError? = nil
    var writingError: FileManagerError? = nil
    
    func encode<T>(_ input: T, to file: String) throws where T : Encodable {
        if let error = writingError {
            throw error
        }
        
        writtenData[file] = input
    }
    
    func decode<T>(_ type: T.Type, from file: String) throws -> T where T : Decodable {
        if let readingError {
            throw readingError
        }
        
        guard let response = response else {
            throw FileManagerError.fileNotFound
        }
        
        return response as! T
    }
    
    func getData(for key: String) throws -> Data {
        throw FileManagerError.fileNotFound
    }
}
