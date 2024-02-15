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
        if let cachedImage = cache.object(forKey: NSString(string: key)) {
            return cachedImage
        }
        
        return getImageFromFiles(key)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
        saveImageInFiles(image, forKey: key)
    }
    
    private func saveImageInFiles(_ image: UIImage, forKey key: String) {
        guard let imageData = image.pngData() else {
            return
        }
        
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(key)")
            try imageData.write(to: fileURL)
        } catch {
            print("Error saving image: \(error)")
        }
    }
    
    private func getImageFromFiles(_ key: String) -> UIImage? {
        do {
            let imageData = try FileManager.default.getData(for: key)
            return UIImage(data: imageData)
        } catch {
            return nil
        }
    }
}

fileprivate enum LoadingPhase {
    case loading
    case failed
    case success(image: UIImage)
}

struct AsyncCachableImage: View {
    @State private var phase: LoadingPhase = .loading
    private let url: URL
    private let placeholder: String
    
    init(url: URL, placeholder: String) {
        self.url = url
        self.placeholder = placeholder
    }
    
    var body: some View {
        switch phase {
        case .loading:
            ProgressView()
                .task {
                    await loadImage()
                }
        case .failed:
            Image(placeholder)
                .resizable()
        case .success(image: let image):
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
    
    private func loadImage() async {
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            phase = .success(image: cachedImage)
            return
        }
        
        do {
            phase = .loading
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200..<300 ~= response.statusCode)else {
                phase = .failed
                return
            }
            
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.setImage(uiImage, forKey: url.absoluteString)
                phase = .success(image: uiImage)
            }
        } catch {
            print("Failed to load image: \(error)")
            phase = .failed
        }
    }
}
