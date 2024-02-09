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
            List(viewModel.items.enumerated().map({$0}), id: \.element.id) { index, artwork in
                Text("\(artwork.title)")
                                        .frame(minWidth: 200, minHeight: 150)
                                        .background(.blue)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .onAppear { viewModel.requestMoreItemsIfNeeded(for: index) }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .padding()
            .refreshable {
                viewModel.refresh()
            }
            .navigationTitle("Artworks")
        }
        .onAppear {
            viewModel.loadInitialItems()
        }
    }
}

#Preview {
    let viewModel = ArtworkListViewModel()
    return ArtworkListView(viewModel: viewModel)
}
