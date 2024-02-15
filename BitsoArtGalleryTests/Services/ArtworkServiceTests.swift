//
//  ArtworkServiceTests.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 14/02/2024.
//

import Foundation
import XCTest

final class ArtworkServiceTests: XCTestCase {
    func testFetchArtworks_whenServiceSucceeds_shouldReturnArtworks_andSaveToFiles() async throws {
        let mockArtworkListResponse = MockArtworks.artworkList
        let networkService = MockNetworkService(defaultResponse: mockArtworkListResponse)
        
        let mockFileManager = MockFileManager()
        
        let service = ArtworkService(networkingService: networkService, fileManager: mockFileManager)
        
        
        let response = try await service.fetchArtworks(page: 1)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(mockArtworkListResponse.data, response.data)
        XCTAssertNotNil(mockFileManager.writtenData["artworks_list_page1.json"])
    }
}
