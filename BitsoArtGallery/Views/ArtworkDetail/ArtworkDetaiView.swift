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
                            Text(viewModel.artwork.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                            
                            if let artistTitle = viewModel.getArtistTitle() {
                                Text(artistTitle)
                                    .foregroundColor(.secondary)
                            } else {
                                SkeletonRectangle()
                            }
                        }
                        
                        if let description = viewModel.getDescription() {
                            Divider()
                                .padding(.horizontal)
                            
                            Text(description)
                                .font(.system(size: 16))
                                .padding(.horizontal)
                                .allowsTightening(true)
                                .fixedSize(horizontal: false, vertical: true)
                        } else {
                            SkeletonRectangle()
                        }

                        Divider()
                            .padding(.horizontal)
                        
                        if let artworkDetail = viewModel.artworkDetail {
                            DisclosureGroup(isExpanded: $showAdditionalInfo) {
                                ArtworkAdditionalInfoView(artwork: artworkDetail)
                            } label: {
                                Text("Additional Details")
                                    .font(.headline)
                            }
                            .padding(.horizontal)
                        } else {
                            SkeletonRectangle()
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.horizontal)
            }
            
            ErrorSnackbar(errorMessage: viewModel.errorMessage, isShowing: $viewModel.isShowingError, dismissAfter: 8.0)
            
        }
        .onAppear {
            Task {
                await viewModel.loadArtwork()
            }
        }
    }
}

#Preview {
    ArtworkDetailView(viewModel: ArtworkDetailViewModel(artworkLoader: ArtworkService(networkingService: NetworkService(), fileManager: FileManager.default), artwork: Artwork(id: 191183, title: "An amazing artwork", artistTitle: "John Doe", departmentTitle: "Contemporary", imageId: "c6da9f8c-643b-f331-0f8f-a9b6a844caf6")))
}
