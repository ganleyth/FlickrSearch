//
//  RecentSearchesViewController.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/30/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class RecentSearchesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var lastTenSearchTerms: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .appDarkGrey
        view.backgroundColor = .appDarkGrey
    }
}

extension RecentSearchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchTerms = UserDefaults.standard.lastTenSearchTerms {
            lastTenSearchTerms = searchTerms
            return searchTerms.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchTerms = lastTenSearchTerms else { fatalError("Calling cellForRowAt when there is no search history.") }
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentSearchCell", for: indexPath)
        cell.textLabel?.text = searchTerms[indexPath.row]
        cell.backgroundColor = .appDarkGrey
        return cell
    }
}

extension RecentSearchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Implement search again
    }
}

extension RecentSearchesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
