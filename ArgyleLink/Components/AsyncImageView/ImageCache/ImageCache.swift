//
//  ImageCache.swift
//  ArgyleLink
//
//  Created by Eszenyi Gábor on 2023. 01. 10..
//

import Foundation
import UIKit.UIImage

class ImageCache: ImageCacheProtocol {

    private let cache = NSCache<NSURL, UIImage>()

    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            guard let newValue else {
                return cache.removeObject(forKey: key as NSURL)
            }
            return cache.setObject(newValue, forKey: key as NSURL)
        }
    }
}
