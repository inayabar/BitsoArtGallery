//
//  ArtworkListView.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 08/02/2024.
//

import SwiftUI

struct ArtworkListView: View {
    @StateObject var viewModel: ArtworkListViewModel
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(viewModel.artworks.enumerated().map({$0}), id: \.element.id) { index, artwork in
                    ArtworkCard(artwork: artwork)
                        .listRowSeparator(.hidden)
                        .onAppear {
                            Task {
                               try! await viewModel.requestMoreItemsIfNeeded(for: index)
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
    let viewModel = ArtworkListViewModel(networkManager: ArtworkService())
    return ArtworkListView(viewModel: viewModel)
}
