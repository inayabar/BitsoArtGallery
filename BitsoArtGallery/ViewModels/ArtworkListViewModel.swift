//
//  ArtworkListViewModel.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import Foundation

class ArtworkListViewModel: ObservableObject {
    private let itemsFromEndThreshold = 8
    
    private var totalItemsAvailable: Int? = 40 // TODO: Should be optional?
    private var itemsLoadedCount: Int? = 0
    private var page = 0
    
    //private let networkService: NetworkService = NetworkService()
    
    @Published var items: [Artwork] = []
    @Published var dataIsLoading = false
    
    func loadInitialItems() {
        (1...10).forEach({
            self.items.append(Artwork(id: $0, title: "Starry night and the \($0)", artistTitle: "Alma Thomas", departmentTitle: "Contemporary", imageId: "", thumbnail: nil))
        })
        
        self.itemsLoadedCount? += 10
        print("Loaded 10 items")
    }
    
    func requestMoreItemsIfNeeded(for index: Int) {
        guard let itemsLoadedCount = itemsLoadedCount,
              let totalItemsAvailable = totalItemsAvailable else {
            return
        }
        
        if scrollingThresholdMet(itemsLoadedCount, index) &&
            moreItemsRemaining(itemsLoadedCount, totalItemsAvailable) {
            print("Requesting more pages for index \(index)")
            // Request next page
            page += 1
            
            (items.count...items.count+10).forEach({
                self.items.append(Artwork(id: $0, title: "Starry night and the \($0)", artistTitle: "Alma Thomas", departmentTitle: "Contemporary", imageId: "", thumbnail: nil))
            })
            self.itemsLoadedCount? += 10
            print("Loading next page") // TODO: Remove
        }
    }
    
    func refresh() {
        items = []
        itemsLoadedCount = 0
        loadInitialItems()
    }
    
    func moreItemsRemaining() -> Bool {
        guard let itemsLoadedCount, let totalItemsAvailable else {
            return false
        }
        
        return itemsLoadedCount < totalItemsAvailable
    }
    
    private func scrollingThresholdMet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
        return (itemsLoadedCount - index) == itemsFromEndThreshold
    }
    
    private func moreItemsRemaining(_ itemsLoadedCount: Int, _ totalItemsAvailable: Int) -> Bool {
        return itemsLoadedCount < totalItemsAvailable
    }
    
}
