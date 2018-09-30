//
//  PhotoTableViewCell.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabelContainer: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(with photo: Photo) {
        
    }
}
