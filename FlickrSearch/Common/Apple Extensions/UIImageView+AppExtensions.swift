//
//  UIImageView+AppExtensions.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 10/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /**
     Loads the image of the provided photo in the image view by first checking the data cache, and then if not available there,
     requesting the data via network call.
     */
    func loadImage(for photo: Photo, size: Photo.Size) {
        self.image = UIImage(named: "defaultImage")
        
        if let image = DataCacheManager.shared.image(for: photo.cacheKey(for: size)) {
            self.image = image
            return
        }
        
        guard let url = photo.imageURL(for: size) else { return }
        NetworkManager.performRequestFor(url: url, queryParameters: nil) { [weak self] (data, response, error) in
            guard let this = self else { return }
            if let error = error {
                NSLog("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Non-200 HTTP response: \(response.statusCode)")
                return
            }
            
            guard let data = data else {
                NSLog("Image data returned is nil.")
                return
            }
            
            this.image = UIImage(data: data)
        }
    }
}
