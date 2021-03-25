//
//  ImageCache.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    public var placeholderImage: UIImage?
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    public func image(for url: NSURL) -> UIImage? {
        cachedImages.object(forKey: url)
    }
    
    public func image(for path: String) -> UIImage? {
        guard let nsurl = NSURL(string: path) else { return nil }
        return image(for: nsurl)
    }
    
    final public func load(url: NSURL, on queue: DispatchQueue = .global(), completion: @escaping (UIImage?) -> Void) {
        // Check if we already have a cached image
        if let cachedImage = image(for: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
     
        // Otherwise, load the image
        queue.async {
            URLSession.shared.dataTask(with: url as URL) { [weak self] (data, _, error) in
                guard
                    let data = data,
                    error == nil,
                    let image = UIImage(data: data)
                else {
                    completion(self?.placeholderImage)
                    return
                }

                self?.cachedImages.setObject(image, forKey: url)
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }.resume()
        }
    }
}
