//
//  URL+AppExtensions.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

extension URL {
    /**
     Generates a URL that results from adding the provided query parameters.
     
     - parameter queryParameters: The parameters to be added to the URL in a dictionary format
     - returns: The original URL with provided query parameters added
     */
    func adding(queryParameters: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        let queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components?.queryItems = queryItems
        
        return components?.url ?? self
    }
}
