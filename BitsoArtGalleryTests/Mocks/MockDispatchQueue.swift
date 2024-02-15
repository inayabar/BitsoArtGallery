//
//  MockDispatchQueue.swift
//  BitsoArtGalleryTests
//
//  Created by Iñaki Yabar Bilbao on 15/02/2024.
//

import Foundation
final class MockDispatchQueue: Dispatching {
    func async(execute workItem: DispatchWorkItem) {
        workItem.perform()
    }
}
