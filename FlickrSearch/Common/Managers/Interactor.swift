//
//  Interactor.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class Interactor: NSObject {
    @IBOutlet weak var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard nil != viewController else {
            fatalError("View controller for \(type(of: self)) must be set in the storyboard.")
        }
    }
}
