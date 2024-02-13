//
//  ArtworkDetaiView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import SwiftUI

struct ArtworkDetaiView: View {
    var artworkId: Int
    
    var body: some View {
        Text("Hello, World! \(artworkId)")
    }
}

#Preview {
    ArtworkDetaiView(artworkId: 12345)
}
