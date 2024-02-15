//
//  ErrorHandlerViewModel.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 14/02/2024.
//

import Foundation

@MainActor
protocol ErrorHandlingViewModel {
    var isShowingError: Bool { get set }
    var errorMessage: String { get set }
}
