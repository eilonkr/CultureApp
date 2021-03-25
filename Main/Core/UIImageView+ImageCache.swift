//
//  UIImage+ImageCache.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import UIKit

extension UIImageView {
    
    func load(url: NSURL, from cacheObject: ImageCache = .shared) {
        cacheObject.load(url: url) { [weak self] image in
            self?.image = image
        }
    }
    
}
