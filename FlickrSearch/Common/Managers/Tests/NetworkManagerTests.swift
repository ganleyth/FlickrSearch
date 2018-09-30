//
//  NetworkManagerTests.swift
//  FlickrSearchTests
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class NetworkManagerTests: XCTestCase {
    
    func testPerformRequest() {
        let mockURLSession = MockURLSession()
        NetworkManager.urlSession = mockURLSession
        guard let url = URL(string: "https://www.apple.com") else { XCTFail(); return }
        let parametersArray = [[
            "key1": "value1",
            "key2": "value2",
            "key3": "value3"
            ], [:]]
        
        for parameters in parametersArray {
            NetworkManager.performRequestFor(url: url, queryParameters: parameters) { (_, _, _) in }
            
            guard let request = mockURLSession.dataTask?.resumedRequest,
                let requestURL = request.url,
                let queryItems = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)?.queryItems else {
                    XCTFail()
                    return
            }
            let requestParameters = queryItems.reduce([String: String]()) { (parameters, item) -> [String: String] in
                var dict = parameters
                dict[item.name] = item.value
                return dict
            }
            
            let requestBaseURLString = String(requestURL.absoluteString.prefix { String($0) != "?" })
            XCTAssertEqual(requestBaseURLString, url.absoluteString)
            XCTAssertEqual(requestParameters, parameters)
            XCTAssertEqual(request.httpMethod, "GET")
        }
    }
}

extension NetworkManagerTests {
    
    class MockURLSession: URLSessionTestable {
        var dataTask: MockDataTask?
        
        func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let dataTask = MockDataTask(request: request)
            self.dataTask = dataTask
            return dataTask
        }
    }
    
    class MockDataTask: URLSessionDataTask {
        private var request: URLRequest?
        var resumedRequest: URLRequest?
        
        init(request: URLRequest) {
            self.request = request
            super.init()
        }
        
        override func resume() {
            resumedRequest = request
        }
    }
}
