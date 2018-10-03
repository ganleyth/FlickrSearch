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
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appTextAlmostWhite]
        navigationBar.barTintColor = .appDarkerGrey
    }
}
