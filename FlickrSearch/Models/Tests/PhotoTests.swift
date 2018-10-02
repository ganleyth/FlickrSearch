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
    
    private lazy var expectedPhoto0 = Photo(id: "45008576281", secret: "3308734c6a", farm: 2, server: "1910", title: "Fenton Handpainted Cobalt Blue Basket")
    private lazy var expectedPhoto1 = Photo(id: "45008573081", secret: "45330c0db5", farm: 2, server: "1941", title: "Fenton Handpainted Cobalt Blue Basket")
    private lazy var expectedPhoto2 = Photo(id: "30072184927", secret: "ff4f5599dd", farm: 2, server: "1934", title: "Fenton Handpainted Cobalt Blue Basket")
    
    func testDecodable() {
        let bundle = Bundle(for: type(of: self))
        guard let filePath = bundle.path(forResource: "SamplePhotos", ofType: "json") else { XCTFail(); return }
        let fileURL = URL(fileURLWithPath: filePath)
        
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
    
    func testCacheString() {
        XCTAssertEqual(expectedPhoto0.cacheKey(for: .small), "n,45008576281,3308734c6a,2,1910")
        XCTAssertEqual(expectedPhoto0.cacheKey(for: .medium), "c,45008576281,3308734c6a,2,1910")
    }
    
    func testImageURL() {
        guard let expectedURLSmall = URL(string: "https://farm2.staticflickr.com/1910/45008576281_3308734c6a_n.jpg"),
            let expectedURLMedium = URL(string: "https://farm2.staticflickr.com/1910/45008576281_3308734c6a_c.jpg"),
            let urlSmall = expectedPhoto0.imageURL(for: .small),
            let urlMedium = expectedPhoto0.imageURL(for: .medium) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(urlSmall, expectedURLSmall)
        XCTAssertEqual(urlMedium, expectedURLMedium)
    }
}
