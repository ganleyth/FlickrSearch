//
//  Constants.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

struct Constants {
    
    struct FlickrAPI {
        
        struct Key {
            static let apiKey = "api_key"
            static let apiKeyPlist = "apiKey"
            static let format = "format"
            static let method = "method"
            static let noJSONCallback = "nojsoncallback"
            static let page = "page"
            static let perPage = "per_page"
            static let searchURL = "searchURL"
            static let sort = "sort"
            static let text = "text"
        }
        
        struct Value {
            static let jsonFormat = "json"
            static let noJSONCallback = "1"
            static let perPage = "25"
            static let searchMethod = "flickr.photos.search"
            static let sortByDateDesc = "relevance"
            
        }
    }
    
    struct UserDefaults {
        static let searchTermHistory = "searchTermHistory"
    }
}
