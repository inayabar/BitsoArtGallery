//
//  ArtworkDetailViewModel.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import Foundation

@MainActor
class ArtworkDetailViewModel: ObservableObject, ErrorHandlingViewModel {
    private let artworkLoader: ArtworkLoader
    private var artworkId: Int
    
    @Published var artwork: ArtworkDetail? = nil
    @Published var isShowingError: Bool = false
    @Published var errorMessage = ""
    
    init(artworkLoader: ArtworkLoader, artworkId: Int) {
        self.artworkLoader = artworkLoader
        self.artworkId = artworkId
    }
    
    func loadArtwork() async throws {
        do {
            let response = try await self.artworkLoader.fetchArtworkDetail(withId: artworkId)
            self.artwork = response.data
            self.isShowingError = false
        } catch {
            self.isShowingError = true
            if let error = error as? ArtworkLoaderError {
                self.errorMessage = error.rawValue
            } else {
                self.errorMessage = "Oh no! Could not load this artwork. Please try again later"
            }
        }
    }
    
    func getImageURL() -> URL? {
        guard let id = artwork?.imageId else {
            return nil
        }
        
         return APIs.Artic.getImage(id: id).url
    }
    
    /*  SwiftUI's Text view does not support attributed strings.
        It is possible to use UITextView via UIViewRepresentable,
        but for the scope of this exercise I decided to clear the html tags from the description
     */
    func getDescription() -> String? {
        guard let description = artwork?.description else {
            return nil
        }
        
        let htmlPattern = "<[^>]+>"
        
        do {
            let regex = try NSRegularExpression(pattern: htmlPattern, options: .caseInsensitive)
            
            // Remove HTML tags from the input string
            let range = NSRange(location: 0, length: description.utf16.count)
            let cleanString = regex.stringByReplacingMatches(in: description, options: [], range: range, withTemplate: "")
            
            return cleanString
        } catch {
            return artwork?.description
        }
    }
}
