//
//  ArtworkListView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import SwiftUI

struct ArtworkListView: View {
    @StateObject var viewModel: ArtworkListViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    var body: some View {
        NavigationView {
            ZStack {
                List() {
                    ForEach(viewModel.artworks.enumerated().map({$0}), id: \.element.id) { index, artwork in
                        NavigationLink {
                            ArtworkDetailView(viewModel: viewModelFactory.makeArtworkDetailViewModel(for: artwork))
                        } label: {
                            ArtworkCard(artwork: artwork)
                                .onAppear {
                                    Task {
                                        await viewModel.requestMoreItemsIfNeeded(for: index)
                                    }
                                }
                        }
                    }
                    lastRowView
                }
                .listStyle(.plain)
                .padding()
                .refreshable {
                    Task {
                        await viewModel.refresh()
                    }
                }
                
                ErrorSnackbar(errorMessage: viewModel.errorMessage, isShowing: $viewModel.isShowingError, dismissAfter: 8.0)
            }
            .navigationTitle("Artworks")
        }
        .onAppear {
            Task {
                await viewModel.loadInitialArtworks()
            }
        }
    }
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.pagingState {
            case .loading:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .listRowSeparator(.hidden)
            case .idle:
                EmptyView()
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    let viewModel = ArtworkListViewModel(artworkLoader: ArtworkService(networkingService: NetworkService(), fileManager: FileManager.default))
    return ArtworkListView(viewModel: viewModel).environmentObject(ViewModelFactory())
}


#Preview {
    let viewModel = ArtworkListViewModel(artworkLoader: ArtworkService(networkingService: NetworkService(), fileManager: FileManager.default))
    viewModel.isShowingError = true
    return ArtworkListView(viewModel: viewModel).environmentObject(ViewModelFactory())
}
