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
        ZStack {
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
                        
                        VStack(spacing: 8) {
                            Text(artwork.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                            
                            Text(artwork.artistDisplay)
                                .foregroundColor(.secondary)
                        }
                        
                        if let description = artwork.description {
                            Divider()
                                .padding(.horizontal)
                            
                            Text(description)
                                .font(.system(size: 16))
                                .padding(.horizontal)
                                .allowsTightening(true)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Divider()
                            .padding(.horizontal)
                        
                        DisclosureGroup(isExpanded: $showAdditionalInfo) {
                            ArtworkAdditionalInfoView(artwork: artwork)
                        } label: {
                            HStack {
                                Text("Additional Details")
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
            
            ErrorSnackbar(errorMessage: viewModel.errorMessage, isShowing: $viewModel.isShowingError, dismissAfter: 8.0)
            
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

#Preview {
    let viewModel = ArtworkDetailViewModel(artworkLoader: ArtworkService(networkingService: NetworkService(), fileManager: FileManager.default), artworkId: 123)
    return ArtworkDetailView(viewModel: viewModel)
}
