//
//  AppNavigationController.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 10/2/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 0.8, alpha: 1.0)]
        navigationBar.barTintColor = .appDarkGrey
    }
}
