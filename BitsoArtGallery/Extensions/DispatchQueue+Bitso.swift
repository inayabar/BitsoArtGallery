//
//  DispatchQueue+Bitso.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
protocol Dispatching {
    func async(execute workItem: DispatchWorkItem)
}

extension DispatchQueue: Dispatching {}
