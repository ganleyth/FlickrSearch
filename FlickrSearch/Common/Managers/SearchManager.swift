//
//  SearchManager.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/30/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class SearchManager {
    static let defaultSearchParams = [
        Constants.FlickrAPI.Key.format: Constants.FlickrAPI.Value.jsonFormat,
        Constants.FlickrAPI.Key.noJSONCallback: Constants.FlickrAPI.Value.noJSONCallback,
        Constants.FlickrAPI.Key.method: Constants.FlickrAPI.Value.searchMethod,
        Constants.FlickrAPI.Key.perPage: Constants.FlickrAPI.Value.perPage,
        Constants.FlickrAPI.Key.sort: Constants.FlickrAPI.Value.sortByDateDesc,
    ]
    
    static var NetworkManagerType: NetworkManagerTestable.Type = NetworkManager.self
    
    static func search(searchTerm: String,
                       page: Int,
                       completion: @escaping (_ photos: [Photo]?, _ error: Error?) -> Void) {
        guard let plistPath = Bundle.main.path(forResource: "FlickrAPI", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: plistPath) else {
                completion(nil, FlickrSearchError.APIPlistNotFound)
                return
        }
        
        guard let flickrURLString = plist[Constants.FlickrAPI.Key.searchURL] as? String,
            let apiKey = plist[Constants.FlickrAPI.Key.apiKeyPlist] as? String,
            let flickrURL = URL(string: flickrURLString) else {
                fatalError("The search URL is not configured properly.")
        }
        
        let queryParameters = [
            Constants.FlickrAPI.Key.apiKey: apiKey,
            Constants.FlickrAPI.Key.page: "\(page)",
            Constants.FlickrAPI.Key.text: searchTerm
        ].merging(SearchManager.defaultSearchParams) { (current, new) in return current }
        
        NetworkManagerType.performRequestFor(url: flickrURL, queryParameters: queryParameters) { (data, response, error) in
            var photos: [Photo]?
            var completionError: Error?
            defer {
                completion(photos, completionError)
            }
            
            if let error = error {
                completionError = error
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionError = FlickrSearchError.HTTPStatusCode
                return
            }
            
            guard let data = data else {
                completionError = FlickrSearchError.DataReturnedIsNil
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(PhotoSearchResponse.self, from: data)
                photos = searchResponse.photos
            } catch {
                completionError = error
                return
            }
        }
    }
}
