//
//  PhotoTests.swift
//  FlickrSearchTests
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class PhotoTests: XCTestCase {

    func testDecodable() {
        let bundle = Bundle(for: type(of: self))
        guard let filePath = bundle.path(forResource: "SamplePhotos", ofType: "json") else { XCTFail(); return }
        let fileURL = URL(fileURLWithPath: filePath)
        
        let expectedPhoto0 = Photo(id: "45008576281", secret: "3308734c6a", farm: 2, server: "1910")
        let expectedPhoto1 = Photo(id: "45008573081", secret: "45330c0db5", farm: 2, server: "1941")
        let expectedPhoto2 = Photo(id: "30072184927", secret: "ff4f5599dd", farm: 2, server: "1934")
        
        let photos: [Photo]
        do {
            let data = try Data(contentsOf: fileURL)
            let searchResponse = try JSONDecoder().decode(PhotoSearchResponse.self, from: data)
            photos = searchResponse.photos
        } catch {
            XCTFail(error.localizedDescription)
            return
        }
        
        XCTAssertEqual(photos.count, 3)
        XCTAssertEqual(photos[0], expectedPhoto0)
        XCTAssertEqual(photos[1], expectedPhoto1)
        XCTAssertEqual(photos[2], expectedPhoto2)
    }
}
