//
//  FlickrSearchError.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

enum FlickrSearchError: Error {
    case APIPlistNotFound
    case DataReturnedIsNil
    case HTTPStatusCode
    
    var localizedDescription: String {
        switch self {
        case .APIPlistNotFound:
            return NSLocalizedString("API_PLIST_NOT_FOUND", comment: "")
        case .DataReturnedIsNil:
            return NSLocalizedString("DATA_RETURNED_IS_NIL", comment: "")
        case .HTTPStatusCode:
            return NSLocalizedString("HTTP_STATUS_CODE", comment: "")
        }
    }
}
