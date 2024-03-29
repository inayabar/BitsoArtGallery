//
//  FileManager+Bitso.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 14/02/2024.
//

import Foundation

protocol FileManaging {
    func encode<T: Encodable>(_ input: T, to file: String) throws
    func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T
    func getData(for key: String) throws -> Data
}

extension FileManager: FileManaging {
    private func getDocumentsDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func encode<T: Encodable>(_ input: T, to file: String) throws {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(input)
        
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
    
    func decode<T: Decodable>(_ type: T.Type, from file: String)  throws -> T {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        
        guard self.fileExists(atPath: url.path) else {
            throw FileManagerError.fileNotFound
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .deferredToDate
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        let data = try Data(contentsOf: url)
        let loaded = try decoder.decode(T.self, from: data)
        return loaded
    }
    
    func getData(for key: String) throws -> Data {
        let url = getDocumentsDirectory().appendingPathComponent("\(key).png")
        return try Data(contentsOf: url)
    }
}

enum FileManagerError: Error, Equatable {
    case fileNotFound
}
