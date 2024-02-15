//
//  ArtworkServiceTests.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 14/02/2024.
//

import Foundation
import XCTest

final class ArtworkServiceTests: XCTestCase {
    let mockDispatchQueue = MockDispatchQueue()
    
    // MARK: Artwork list
    func testFetchArtworks_whenServiceSucceeds_shouldReturnArtworks_andSaveToFiles() async throws {
        let mockArtworkListResponse = MockArtworks.artworkList
        let networkService = MockNetworkService(defaultResponse: mockArtworkListResponse)
        
        let mockFileManager = MockFileManager()
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager, dispatcher: mockDispatchQueue)
        
        
        let response = try await service.fetchArtworks(page: 1)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(mockArtworkListResponse.data, response.data)
        XCTAssertNotNil(mockFileManager.writtenData["artworks_list_page1.json"])
    }
    
    func testFetchArtworks_whenOffline_shouldReturnSavedArtworks() async throws {
        let mockArtworkListResponse = MockArtworks.artworkList
        let networkService = OfflineNetworkService()
        
        let mockFileManager = MockFileManager()
        mockFileManager.response = mockArtworkListResponse
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager, dispatcher: mockDispatchQueue)
        
        
        let response = try await service.fetchArtworks(page: 1)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(mockArtworkListResponse.data, response.data)
    }
    
    func testFetchArtworks_whenOfflineAndNoSavedArtworks_shouldThrow() async throws {
        let networkService = OfflineNetworkService()
        
        let mockFileManager = MockFileManager()
        mockFileManager.readingError = FileManagerError.fileNotFound
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager, dispatcher: mockDispatchQueue)
        
        do {
            _ = try await service.fetchArtworks(page: 1)
            XCTFail("Error needs to be thrown")
        } catch {
            //Do nothing, if error is thrown then it matches expected result
        }
    }
    
    // MARK: Artwork detail
    func testFetchArtworkDetail_whenServiceSucceeds_shouldReturnArtwork_andSaveToFiles() async throws {
        let mockArtworkDetailResponse = MockArtworks.artworkDetailResponse
        let networkService = MockNetworkService(defaultResponse: mockArtworkDetailResponse)
        
        let mockFileManager = MockFileManager()
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager, dispatcher: mockDispatchQueue)
        
        
        let response = try await service.fetchArtworkDetail(withId: mockArtworkDetailResponse.data.id)
        
        XCTAssertNotNil(response)
        XCTAssertNotNil(mockFileManager.writtenData["artwork_detail_123.json"])
    }
    
    func testFetchArtworkDetail_whenOffline_shouldReturnSavedArtwork() async throws {
        let mockArtworkDetailResponse = MockArtworks.artworkDetailResponse
        let networkService = OfflineNetworkService()
        
        let mockFileManager = MockFileManager()
        mockFileManager.response = mockArtworkDetailResponse
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager, dispatcher: mockDispatchQueue)
        
        
        let response = try await service.fetchArtworkDetail(withId: mockArtworkDetailResponse.data.id)
        
        XCTAssertNotNil(response)
    }
    

    func testFetchArtworkDetail_whenOfflineAndNoSavedArtwork_shouldThrow() async throws {
        let networkService = OfflineNetworkService()
        
        let mockFileManager = MockFileManager()
        mockFileManager.readingError = FileManagerError.fileNotFound
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager, dispatcher: mockDispatchQueue)
        
        do {
            _ = try await service.fetchArtworkDetail(withId: 123)
            XCTFail("Error needs to be thrown")
        } catch {
            //Do nothing, if error is thrown then it matches expected result
        }
    }
}
