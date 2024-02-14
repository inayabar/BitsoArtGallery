//
//  ArtworkAdditionalInfoView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 14/02/2024.
//

import SwiftUI

struct ArtworkAdditionalInfoView: View {
    let artwork: ArtworkDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if let inscriptions = artwork.inscriptions {
                Text("Inscriptions: \(inscriptions)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            
            if let creditLine = artwork.creditLine {
                Text("Credit Line: \(creditLine)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            
            if let publicationHistory = artwork.publicationHistory {
                Text("Publication History: \(publicationHistory)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
