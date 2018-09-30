//
//  SearchManagerTests.swift
//  FlickrSearchTests
//
//  Created by Thomas Ganley on 9/30/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class SearchManagerTests: XCTestCase {

    func testSearchRequestsProperURLAndParams() {
        guard let plistPath = Bundle(for: SearchManager.self).path(forResource: "FlickrAPI", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: plistPath),
            let searchURLString = plist[Constants.FlickrAPI.Key.searchURL] as? String,
            let apiKey = plist[Constants.FlickrAPI.Key.apiKeyPlist] as? String,
            let searchURL = URL(string: searchURLString) else { XCTFail(); return }
        
        SearchManager.NetworkManagerType = MockNetworkManager.self
        SearchManager.search(searchTerm: "testSearchTerm", page: 1) { (_, _) in }
        
        guard let requestedURL = MockNetworkManager.url,
            let requestedParams = MockNetworkManager.queryParameters else { XCTFail(); return }
        
        let expectedParams = [
            Constants.FlickrAPI.Key.text: "testSearchTerm",
            Constants.FlickrAPI.Key.page: "1",
            Constants.FlickrAPI.Key.apiKey: apiKey
            ].merging(SearchManager.defaultSearchParams) { (current, new) in return current }
        
        XCTAssertEqual(requestedURL, searchURL)
        XCTAssertEqual(requestedParams, expectedParams)
    }
}

private extension SearchManagerTests {
    
    final class MockNetworkManager: NetworkManagerTestable {
        static var url: URL?
        static var queryParameters: [String: String]?
        
        static func performRequestFor(url: URL, queryParameters: [String: String]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
            MockNetworkManager.url = url
            MockNetworkManager.queryParameters = queryParameters
        }
    }
}
