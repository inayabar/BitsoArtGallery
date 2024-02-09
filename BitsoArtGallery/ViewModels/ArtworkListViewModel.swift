//
//  ArtworkListViewModel.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

public enum PagingState {
    case idle
    case loading
    case error(error: Error)
}

class ArtworkListViewModel: ObservableObject {
    private let itemsFromEndThreshold = 3
    
    private var totalArtworks: Int? = 40 // TODO: Should be optional?
    private var page = 0
    
    //private let networkService: NetworkService = NetworkService()
    
    @Published var artworks: [Artwork] = []
    @Published var isLoading = false
    @Published var pagingState: PagingState = .idle
    
    private var moreArtworksRemaining: Bool {
        return artworks.count < (totalArtworks ?? 0)
    }
    
    func loadInitialArtworks() {
        pagingState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            (1...10).forEach({
                self.artworks.append(Artwork(id: $0, title: "Starry night and the \($0)", artistTitle: "Alma Thomas", departmentTitle: "Contemporary", imageId: "", thumbnail: nil))
            })
            self.pagingState = .idle
        }
    }
    
    func requestMoreItemsIfNeeded(for index: Int) {
        if scrollingThresholdMet(at: index) && moreArtworksRemaining {
            page += 1
            
            print("fetching page \(page)")
            self.pagingState = .loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else {
                    return
                }
                
                (self.artworks.count+1...self.artworks.count+10).forEach({
                    self.artworks.append(Artwork(id: $0, title: "Starry night and the \($0)", artistTitle: "Alma Thomas", departmentTitle: "Contemporary", imageId: "", thumbnail: nil))
                })
                self.pagingState = .idle
                print("finished fetching page \(page)")
            }
        }
    }
    
    func refresh() {
        artworks = []
        loadInitialArtworks()
    }
    
    private func scrollingThresholdMet(at index: Int) -> Bool {
        return (artworks.count - index) == itemsFromEndThreshold
    }
}
