//
//  AsyncCachableImage.swift
//  BitsoArtGallery
//
//  Created by Iñaki Yabar Bilbao on 09/02/2024.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}

struct AsyncCachableImage: View {
    @StateObject private var imageLoader = ImageLoader()
    @State private var image: UIImage?
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        imageLoader.loadImage(from: url) { loadedImage in
            if let loadedImage = loadedImage {
                ImageCache.shared.setImage(loadedImage, forKey: url.absoluteString)
                self.image = loadedImage
            }
        }
    }
}

class ImageLoader: ObservableObject {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(uiImage)
            }
        }.resume()
    }
}
