//
//  ArtworkListViewModelTests.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
import XCTest

final class ArtworkListViewModelTests: XCTestCase {
    private var viewModel: ArtworkListViewModel!
    
    @MainActor
    func testLoadInitialArtworks_whenServiceSucceeds_shouldAppendItems() async {
        let artworks = [MockArtworks.artworkWithImage, MockArtworks.artworkWithoutImage]
        let loader = MockArtworkLoader()
        loader.artworks = artworks
        viewModel = ArtworkListViewModel(artworkLoader: loader)
        
        await viewModel.loadInitialArtworks()
        
        XCTAssertEqual(2, viewModel.artworks.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(.idle, viewModel.pagingState)
    }
    
    @MainActor
    func testLoadInitialArtworks_whenServiceSucceeds_shouldNotAppendRepeatedItems() async {
        let artworks = [MockArtworks.artworkWithImage, MockArtworks.artworkWithImage]
        let loader = MockArtworkLoader()
        loader.artworks = artworks
        viewModel = ArtworkListViewModel(artworkLoader: loader)
        
        await viewModel.loadInitialArtworks()
        
        XCTAssertEqual(1, viewModel.artworks.count)
    }
    
    @MainActor
    func testLoadInitialArtworks_whenServiceThrows_shouldShowError() async {
        let error = ArtworkLoaderError.couldNotLoadArtwork
        let loader = ThrowingMockArtworkLoader(error: error)
        viewModel = ArtworkListViewModel(artworkLoader: loader)
        await viewModel.loadInitialArtworks()
        
        XCTAssertEqual(0, viewModel.artworks.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.isShowingError)
        XCTAssertEqual(error.rawValue, viewModel.errorMessage)
    }
    
    @MainActor
    func testRequestMoreItems_whenThresholdIsNotMet_shouldNotRequest() async {
        let artworks = [MockArtworks.artworkWithImage, MockArtworks.artworkWithoutImage]
        let loader = MockArtworkLoader()
        loader.artworks = artworks
        
        viewModel = ArtworkListViewModel(artworkLoader: loader)
        await viewModel.loadInitialArtworks()
        
        await viewModel.requestMoreItemsIfNeeded(for: 2)
        
        XCTAssertEqual(2, viewModel.artworks.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(.idle, viewModel.pagingState)
    }
    
    @MainActor
    func testRequestMoreItems_whenThresholdIsMet_shouldRequestMoreItems() async {
        let artworks = [MockArtworks.artworkWithoutImage]
        let loader = MockArtworkLoader()
        loader.artworks = artworks
        
        viewModel = ArtworkListViewModel(artworkLoader: loader)
        viewModel.totalArtworks = 20
        viewModel.artworks = Array(repeating: MockArtworks.artworkWithImage, count: 14)
        
        await viewModel.requestMoreItemsIfNeeded(for: 2)
        
        XCTAssertEqual(15, viewModel.artworks.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(.idle, viewModel.pagingState)
    }
    
    @MainActor
    func testRefresh_shouldResetStateAndLoadFirstPage() async {
        let artworks = [MockArtworks.artworkWithoutImage]
        let loader = MockArtworkLoader()
        loader.artworks = artworks
        
        viewModel = ArtworkListViewModel(artworkLoader: loader)
        viewModel.totalArtworks = 20
        viewModel.artworks = Array(repeating: MockArtworks.artworkWithImage, count: 14)
        
        await viewModel.refresh()
        
        XCTAssertEqual(1, viewModel.artworks.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(.idle, viewModel.pagingState)
    }
}
