//
//  UserDefaults+AppExtensions.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 10/2/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

extension UserDefaults {
    var lastTenSearchTerms: [String]? {
        return object(forKey: Constants.UserDefaults.searchTermHistory) as? [String]
    }
    
    func pushSearchTermOntoSearchHistory(searchTerm: String) {
        let newSearchHistory: [String]
        if var searchHistory = UserDefaults.standard.object(forKey: Constants.UserDefaults.searchTermHistory) as? [String] {
            searchHistory.insert(searchTerm, at: 0)
            if searchHistory.count > 10 {
                _ = searchHistory.popLast()
            }
            newSearchHistory = searchHistory
        } else {
            newSearchHistory = [searchTerm]
        }
        
        set(newSearchHistory, forKey: Constants.UserDefaults.searchTermHistory)
    }
}
