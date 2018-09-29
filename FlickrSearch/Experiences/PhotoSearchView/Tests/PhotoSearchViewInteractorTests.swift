//
//  PhotoSearchViewInteractorTests.swift
//  FlickrSearchTests
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class PhotoSearchViewInteractorTests: XCTestCase {
    func testViewControllerIsSetInStoryboard() {
        guard let photoSearchViewController = UIStoryboard(name: "PhotoSearchView", bundle: Bundle(for: PhotoSearchViewController.self)).instantiateInitialViewController() as? PhotoSearchViewController else {
            XCTFail("Could not instantiate the photo search view controller.")
            return
        }
        
        XCTAssertNotNil(photoSearchViewController.interactor.viewController)
    }
}
