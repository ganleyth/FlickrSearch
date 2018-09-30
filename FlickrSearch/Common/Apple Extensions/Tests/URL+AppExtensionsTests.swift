//
//  URL+AppExtensionsTests.swift
//  FlickrSearchTests
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class URL_AppExtensionsTests: XCTestCase {
    
    func testURLAddingQueryParameters() {
        guard let url = URL(string: "https://www.apple.com") else { XCTFail(); return }
        let parameters = [
            "key1": "value1",
            "key2": "value2",
            "key3": "value3"
        ]
        
        let urlPlusParameters = url.adding(queryParameters: parameters)
        
        guard let components = URLComponents(url: urlPlusParameters, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems else { XCTFail("Invalid URL"); return }
        
        let returnedURLParameters = queryItems.reduce([String: String]()) { (parameters, item) -> [String: String] in
            var dict = parameters
            dict[item.name] = item.value
            return dict
        }
        
        XCTAssertEqual(returnedURLParameters, parameters)
    }
}
