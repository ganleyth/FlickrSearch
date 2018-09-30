//
//  NetworkManager.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

protocol URLSessionTestable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionTestable {}

class NetworkManager {
    
    static var urlSession: URLSessionTestable = URLSession.shared
    
    /**
     Performs a network request with the provided URL, HTTP method, and URL parameters.
     
     - parameter url: The URL endpoint
     - parameter queryParameters: The query parameters for the request, in dictionary format
     - parameter completion: The completion handler for the network request
     */
    static func performRequestFor(url: URL,
                                  queryParameters: [String: String]? = nil,
                                  completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        var requestURL = url
        if let queryParameters = queryParameters {
            requestURL = url.adding(queryParameters: queryParameters)
        }
        
        let request = URLRequest(url: requestURL)
        let dataTask = NetworkManager.urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
        
        dataTask.resume()
    }
}
