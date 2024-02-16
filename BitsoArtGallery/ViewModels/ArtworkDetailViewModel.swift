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
    
    @Published var artwork: Artwork
    @Published var artworkDetail: ArtworkDetail? = nil
    @Published var isShowingError: Bool = false
    @Published var errorMessage = ""
    
    init(artworkLoader: ArtworkLoader, artwork: Artwork) {
        self.artworkLoader = artworkLoader
        self.artwork = artwork
    }
    
    func loadArtwork() async {
        do {
            let response = try await self.artworkLoader.fetchArtworkDetail(withId: artwork.id)
            self.artworkDetail = response.data
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
        guard let id = artwork.imageId else {
            return nil
        }
        
         return APIs.Artic.getImage(id: id).url
    }
    
    func getArtistTitle() -> String? {
        if let artworkDetail, let artistDisplay = artworkDetail.artistDisplay {
            return artistDisplay
        }
        
        return artwork.artistTitle
    }
    
    /*  SwiftUI's Text view does not support attributed strings.
        It is possible to use UITextView via UIViewRepresentable,
        but for the scope of this exercise I decided to clear the html tags from the description
     */
    func getDescription() -> String? {
        guard let artworkDetail else {
            return nil
        }
        
        guard let description = artworkDetail.description else {
            return "No description available"
        }
        
        let htmlTagPattern = "<[^>]+>"
        
        do {
            let regex = try NSRegularExpression(pattern: htmlTagPattern, options: .caseInsensitive)
            
            // Remove HTML tags from the input string
            let range = NSRange(location: 0, length: description.utf16.count)
            let cleanString = regex.stringByReplacingMatches(in: description, options: [], range: range, withTemplate: "")
            
            return cleanString
        } catch {
            return artworkDetail.description
        }
    }
}
