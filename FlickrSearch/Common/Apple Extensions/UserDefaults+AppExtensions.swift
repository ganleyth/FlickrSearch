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
        if var searchHistory = lastTenSearchTerms {
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
    
    func shiftSearchTermToTopOfSearchHistory(searchTerm: String) {
        guard var searchHistory = lastTenSearchTerms,
            let index = searchHistory.firstIndex(of: searchTerm) else { return }
        searchHistory.remove(at: index)
        if searchHistory.count > 0 {
            searchHistory.insert(searchTerm, at: 0)
        } else {
            searchHistory = [searchTerm]
        }
        
        set(searchHistory, forKey: Constants.UserDefaults.searchTermHistory)
    }
}
