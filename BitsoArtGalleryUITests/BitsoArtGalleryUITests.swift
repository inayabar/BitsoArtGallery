//
//  BitsoArtGalleryUITests.swift
//  BitsoArtGalleryUITests
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import XCTest

final class BitsoArtGalleryUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchArguments = ["-UITests"]
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testCardsAreShown() throws {
        
        // Assert all cards are shown
        MockArtworkLoader.artworks.forEach({ artwork in
            let titleLabel = app.staticTexts[artwork.title]
            XCTAssertEqual(titleLabel.label, artwork.title)
            
            if let artistTitle = artwork.artistTitle {
                let artistLabel = app.staticTexts[artistTitle]
                XCTAssertEqual(artistLabel.label, artistTitle)
            }
        })
        
        // Assert cards with image 
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
