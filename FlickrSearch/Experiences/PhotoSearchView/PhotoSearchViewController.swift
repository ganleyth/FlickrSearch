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
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "photoCell")
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = interactor
        searchBar.delegate = interactor
    }
}
