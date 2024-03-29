//
//  BitsoArtGalleryApp.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import SwiftUI

@main
struct BitsoArtGalleryApp: App {
    let viewModelFactory = ViewModelFactory()
    
    var body: some Scene {
        WindowGroup {
            ArtworkListView(viewModel: viewModelFactory.makeArtworkListViewModel())
                .environmentObject(viewModelFactory)
        }
    }
}
