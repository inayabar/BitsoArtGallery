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

enum ArtworkLoaderError: String, Error {
    case invalidUrl = "This artwork created an invalid request. Please try again"
    case offlineAndNotCached = "It seems you are offline and we couldn't fetch more artworks. Please try again"
    case couldNotLoadArtwork = "Could not load this artwork. Please try again"
}

class ArtworkService: ArtworkLoader {
    let networkingService: NetworkService
    let fileManager: FileManager
    
    init(networkingService: NetworkService, fileManager: FileManager) {
        self.networkingService = networkingService
        self.fileManager = fileManager
    }
    
    func fetchArtworks(page: Int) async throws -> ArtworkList {
        guard let url = APIs.Artic.getArtworks(page: page).url else {
            throw ArtworkLoaderError.invalidUrl
        }
        
        let resource = Resource.init(request: URLRequest(url: url), responseType: ArtworkList.self)
        
        do {
            let artworkList = try await networkingService.load(resource: resource)
            
            saveToFile(artworkList, fileName: artworkListFileName(page: page))
            return artworkList
        } catch {
            guard let error = error as? NetworkError, error == .notConnectedToInternet else { throw error }
            
            // User is offline, attempt to fetch page from files
            return try fetchArtworksFromFiles(page: page)
        }
    }
    
    func fetchArtworkDetail(withId id: Int) async throws -> ArtworkDetailResponse? {
        guard let url = APIs.Artic.getArtwork(id: id).url else {
            throw NetworkError.invalidUrlError
        }
        
        let resource = Resource.init(request: URLRequest(url: url), responseType: ArtworkDetailResponse.self)
        
        do {
            let artworkDetailResponse = try await networkingService.load(resource: resource)
            
            saveToFile(artworkDetailResponse, fileName: artworkDetailFileName(artworkId: id))
            return artworkDetailResponse
        } catch {
            guard let error = error as? NetworkError, error == .notConnectedToInternet else { throw error }
            
            // User is offline, attempt to fetch artwork from files
            return try fetchArtworkDetailFromFiles(artworkId: id)
        }
    }
    
    // MARK: File management
    private func artworkListFileName(page: Int) -> String {
        return "artworks_list_page\(page).json"
    }
    
    private func artworkDetailFileName(artworkId: Int) -> String{
        return "artwork_detail_\(artworkId).json"
    }
    
    private func fetchArtworksFromFiles(page: Int) throws -> ArtworkList {
        do {
            return try fileManager.decode(ArtworkList.self, from: artworkListFileName(page: page))
        } catch {
            guard let error = error as? FileManagerError, error == .fileNotFound else { throw error }
            throw ArtworkLoaderError.offlineAndNotCached
        }
    }
    
    private func fetchArtworkDetailFromFiles(artworkId: Int) throws -> ArtworkDetailResponse {
        do {
            return try fileManager.decode(ArtworkDetailResponse.self, from: artworkDetailFileName(artworkId: artworkId))
        } catch {
            throw error // TODO: Check if error was file not found
        }
    }
    
    private func saveToFile<T: Encodable>(_ input: T, fileName: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                return
            }
            
            do {
                try fileManager.encode(input, to: fileName)
            }
            catch {
                //
                print(error)
            }
        }
    }
}
