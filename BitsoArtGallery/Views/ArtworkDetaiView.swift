//
//  ArtworkDetaiView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import SwiftUI

struct ArtworkDetaiView: View {
    @StateObject var viewModel: ArtworkDetailViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    ArtworkDetaiView(viewModel: ArtworkDetailViewModel(artworkLoader: ArtworkService(), artworkId: 123))
}
