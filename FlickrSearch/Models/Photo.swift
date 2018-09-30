//
//  Photo.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

struct PhotoSearchResponse: Decodable {
    let photoResponse: PhotosResponse
    
    var photos: [Photo] {
        return photoResponse.photos
    }
    
    private enum CodingKeys: String, CodingKey {
        case photoResponse = "photos"
    }
}

struct PhotosResponse: Decodable {
    let photos: [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

struct Photo: Decodable {
    let id: String
    let secret: String
    let farm: Int
    let server: String
}

extension Photo {
    enum Size: String {
        case small = "n"
        case medium = "c"
    }
    
    func cacheString(for size: Size) -> String {
        return "\(size.rawValue),\(id),\(secret),\(farm),\(server)"
    }
    
    func imageURL(for size: Size) -> URL? {
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).jpg"
        return URL(string: urlString)
    }
}

// MARK: - Equatable
extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        if lhs.id != rhs.id { return false }
        if lhs.secret != rhs.secret { return false }
        if lhs.farm != rhs.farm { return false }
        if lhs.server != rhs.server { return false }
        return true
    }
}
