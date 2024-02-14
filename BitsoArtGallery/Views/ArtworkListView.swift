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
            List() {
                ForEach(viewModel.artworks.enumerated().map({$0}), id: \.element.id) { index, artwork in
                    NavigationLink {
                        ArtworkDetailView(viewModel: viewModelFactory.makeArtworkDetailViewModel(for: artwork.id))
                    } label: {
                        ArtworkCard(artwork: artwork)
                            .onAppear {
                                Task {
                                   try! await viewModel.requestMoreItemsIfNeeded(for: index)
                                }
                        }
                            .buttonStyle(.plain)
                            .listRowSeparator(.hidden)
                    }
                }
                lastRowView
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .padding()
            .refreshable {
                Task {
                    await viewModel.refresh()
                }
            }
            .navigationTitle("Artworks")
        }
        .onAppear {
            Task {
                try! await viewModel.loadInitialArtworks()
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
            case .error(_):
                EmptyView()
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    let viewModel = ArtworkListViewModel(artworkLoader: ArtworkService())
    return ArtworkListView(viewModel: viewModel).environmentObject(ViewModelFactory())
}
