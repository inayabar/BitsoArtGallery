//
//  ArtworkDetaiView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 13/02/2024.
//

import SwiftUI

struct ArtworkDetailView: View {
    @StateObject var viewModel: ArtworkDetailViewModel
    @State private var showAdditionalInfo = false
    
    var body: some View {
        ScrollView {
            if let artwork = viewModel.artwork {
                VStack(alignment: .leading, spacing: 20) {
                    if let imageUrl = viewModel.getImageURL() {
                        AsyncCachableImage(url: imageUrl, placeholder: "ArtworkPlaceholder")
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 400)
                    } else {
                        Image("ArtworkPlaceholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(artwork.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Artist: \(artwork.artistDisplay)")
                            .foregroundColor(.secondary)
                        
                        Text("Date: \(artwork.dateDisplay)")
                            .foregroundColor(.secondary)
                        
                        Text("Medium: \(artwork.mediumDisplay)")
                            .foregroundColor(.secondary)
                        
                        Text("Dimensions: \(artwork.dimensions)")
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    if let description = artwork.description {
                        Text("Description:")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Text(description)
                            .padding(.horizontal)
                            .allowsTightening(true)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    if let inscriptions = artwork.inscriptions {
                        Text("Inscriptions: \(inscriptions)")
                            .padding(.horizontal)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    DisclosureGroup(isExpanded: $showAdditionalInfo) {
                        ArtworkAdditionalInfoView(artwork: artwork)
                    } label: {
                        HStack {
                            Text("Additional Info")
                                .font(.headline)
                            
                            Spacer()
                            
                            Image(systemName: showAdditionalInfo ? "chevron.up" : "chevron.down")
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    }
                }
                .foregroundColor(.primary)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                try! await viewModel.loadArtwork()
            }
        }
    }
}

#Preview {
    ArtworkDetailView(viewModel: ArtworkDetailViewModel(artworkLoader: ArtworkService(networkingService: NetworkService(), fileManager: FileManager.default), artworkId: 191183))
}
