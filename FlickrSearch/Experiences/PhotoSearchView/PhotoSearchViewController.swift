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
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = interactor
        searchController.searchBar.delegate = interactor
        definesPresentationContext = true
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = interactor
        setupTableView()
    }
    
    func refreshUI() {
        tableView.reloadData()
        searchController.isActive = false
    }
}

// MARK: - Private helpers
private extension PhotoSearchViewController {
    func setupTableView() {
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "photoCell")
        let backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = .appDarkGrey
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
