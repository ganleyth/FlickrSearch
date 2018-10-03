//
//  UIViewController+AppExtensions.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 10/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     Presents a basic alert with a title and a message, along with an 'OK' button that the user can use to dismiss the alert.
     */
    func presentBasicInfoAlertWith(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ALERT_BUTTON_OK", comment: ""),
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
