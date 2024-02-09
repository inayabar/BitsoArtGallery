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
                    Text("\(artwork.title)")
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .background(.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .font(.title)
                        .listRowSeparator(.hidden)
                        .onAppear { viewModel.requestMoreItemsIfNeeded(for: index) }
                }
                lastRowView
            }
            .listStyle(.plain)
            .padding()
            .refreshable {
                viewModel.refresh()
            }
            .navigationTitle("Artworks")
        }
        .onAppear {
            viewModel.loadInitialArtworks()
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
            case .error(let _):
                EmptyView()
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    let viewModel = ArtworkListViewModel()
    return ArtworkListView(viewModel: viewModel)
}
