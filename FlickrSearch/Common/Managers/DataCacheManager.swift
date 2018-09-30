//
//  DataCacheManager.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

typealias PhotoKey = String

class DataCacheManager {
    static let shared = DataCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func cache(image: UIImage, with key: PhotoKey) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(for photoKey: PhotoKey) -> UIImage? {
        return cache.object(forKey: photoKey as NSString)
    }
}
