//
//  PhotoSearchViewController.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

final class PhotoSearchViewController: UIViewController {
    
    @IBOutlet private(set) var interactor: PhotoSearchViewInteractor!
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var enterSearchTermLabel: UILabel? = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = NSLocalizedString("ENTER_SEARCH_TERM", comment: "")
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.alpha = 0.3
        return label
    }()
    
    private lazy var searchController: UISearchController = {
        guard let resultsController = UIStoryboard(name: "RecentSearchesView", bundle: nil)
            .instantiateInitialViewController() as? RecentSearchesViewController else {
            fatalError("Cannot instantiate the recent searches view.")
        }
        resultsController.delegate = interactor
        let searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = NSLocalizedString("SEARCH_BAR_PLACEHOLDER", comment: "")
        searchController.searchResultsUpdater = interactor
        searchController.searchBar.delegate = interactor
        searchController.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autocorrectionType = .no
        let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        searchField?.textColor = .white
        definesPresentationContext = true
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = interactor
        tableView.delegate = interactor
        view.backgroundColor = .appDarkerGrey
        setupTableView()
    }
    
    func refreshUI() {
        enterSearchTermLabel?.removeFromSuperview()
        enterSearchTermLabel = nil
        tableView.reloadData()
        searchController.isActive = false
    }
    
    func presentDetailView(with photo: Photo) {
        guard let detailView = UIStoryboard(name: "PhotoDetailView", bundle: nil).instantiateInitialViewController() as? PhotoDetailViewController else { return }
        detailView.photo = photo
        present(detailView, animated: true, completion: nil)
    }
}

// MARK: - Search controller delegate
extension PhotoSearchViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
}

// MARK: - Private helpers
private extension PhotoSearchViewController {
    func setupTableView() {
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "photoCell")
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.scrollsToTop = true
        let backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = .appDarkerGrey
        tableView.backgroundView = backgroundView
        if let label = enterSearchTermLabel {
            enhanceTableViewBackground(with: label)
        }
    }
    
    func enhanceTableViewBackground(with label: UILabel) {
        guard let backgroundView = tableView.backgroundView else { return }
        backgroundView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.8).isActive = true
        label.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 100).isActive = true
    }
}
