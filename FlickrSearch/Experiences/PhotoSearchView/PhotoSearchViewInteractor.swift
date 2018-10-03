//
//  PhotoSearchViewInteractor.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class PhotoSearchViewInteractor: Interactor {
    private var photos: [Photo] = []
    private var currentPage = 1
    private var lastSearchTerm: String?
    
    private var bottomCellIndexPath: IndexPath {
        return IndexPath(row: photos.count - 1, section: 0)
    }
    
    private var photoSearchViewController: PhotoSearchViewController? {
        return viewController as? PhotoSearchViewController
    }
    
    private func search(with searchTerm: String) {
        lastSearchTerm = searchTerm
        SearchManager.search(searchTerm: searchTerm, page: currentPage) { [weak self] result in
            guard let this = self else { return }
            
            switch result {
            case .success(let photos):
                this.photos += photos
                this.photoSearchViewController?.refreshUI()
            case .failure(let error):
                NSLog("Error performing photo search: \(error.localizedDescription)")
                this.viewController?.presentBasicInfoAlertWith(title: NSLocalizedString("SEARCH_ERROR_TITLE", comment: ""),
                                                               message: NSLocalizedString("SEARCH_ERROR_MESSAGE", comment: ""))
                return
            }
        }
    }
}

// MARK: - Table view data source
extension PhotoSearchViewInteractor: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else { return PhotoTableViewCell() }
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        
        return cell
    }
}

// MARK: - Table view delegate
extension PhotoSearchViewInteractor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath == bottomCellIndexPath,
            let lastSearchTerm = lastSearchTerm, !lastSearchTerm.isEmpty else { return }
        currentPage += 1
        search(with: lastSearchTerm)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photoSearchViewController = photoSearchViewController else { return }
        let photo = photos[indexPath.row]
        photoSearchViewController.presentDetailView(with: photo)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Search bar delegate
extension PhotoSearchViewInteractor: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        photos = []
        search(with: searchTerm)
        UserDefaults.standard.pushSearchTermOntoSearchHistory(searchTerm: searchTerm)
    }
}

// MARK: - Search results updating
extension PhotoSearchViewInteractor: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Update the previously used search terms
        // For more polish, I would filter the previously used search terms here so that the user can start typing and then
        // see the search terms they've already used in the past.
    }
}

// MARK: - Recent searches delegate
extension PhotoSearchViewInteractor: RecentSearchesDelegate {
    func didSelectRecentSearchTerm(_ searchTerm: String) {
        photos = []
        search(with: searchTerm)
        UserDefaults.standard.shiftSearchTermToTopOfSearchHistory(searchTerm: searchTerm)
    }
}
