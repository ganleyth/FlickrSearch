//
//  DataCacheManager.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class DataCacheManager {
    static let shared = DataCacheManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    func cache(image: UIImage) {
        
    }
    
    func image(for photo: Photo) -> UIImage? {
        return UIImage()
    }
    
    private func identifierString(for photo: Photo) -> String {
        return ""
    }
}
