//
//  ArtworkDetailViewModelTests.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
import XCTest

final class ArtworkDetailViewModelTests: XCTestCase {
    private var viewModel: ArtworkDetailViewModel!
    
    @MainActor
    func testLoadArtwork_whenServiceSucceeds_shouldRenderArtwork() async {
        
        let loader = MockArtworkLoader()
        viewModel = ArtworkDetailViewModel(artworkLoader: loader, artwork: MockArtworks.artworkWithImage)
        
        await viewModel.loadArtwork()
        
        XCTAssertNotNil(viewModel.artwork)
        XCTAssertFalse(viewModel.isShowingError)
    }
    
    @MainActor
    func testLoadArtwork_whenServiceFails_shouldRenderError() async {
        
        let loader = MockArtworkLoader()
        viewModel = ArtworkDetailViewModel(artworkLoader: loader, artwork: MockArtworks.artworkWithoutImage)
        
        await viewModel.loadArtwork()
        
        XCTAssertNil(viewModel.artworkDetail)
        XCTAssertTrue(viewModel.isShowingError)
    }
    
    @MainActor
    func testGetDescription_shouldRemoveHTMLFromDescription() {
        
        let loader = MockArtworkLoader()
        viewModel = ArtworkDetailViewModel(artworkLoader: loader, artwork: MockArtworks.artworkWithImage)
        
        let artworkDetail = ArtworkDetail(id: 123,
                                                         title: "Some art",
                                                         artistDisplay: "John Doe",
                                                         dateDisplay: "2022",
                                                         mediumDisplay: "Oil on canvas",
                                                         dimensions: "50 x 50 cm",
                                                         description: "<p>This is a beautiful artwork created by John Doe.</p>",
                                                         imageId: "image_123",
                                                         inscriptions: "Signed by the artist.",
                                                         creditLine: "Gift of John Doe",
                                                         galleryTitle: "Gallery 1",
                                                         departmentTitle: "Modern Art")
        viewModel.artworkDetail = artworkDetail
        let result = viewModel.getDescription()
        
        XCTAssertNotNil(result)
        XCTAssertEqual("This is a beautiful artwork created by John Doe.", result)
    }
}
