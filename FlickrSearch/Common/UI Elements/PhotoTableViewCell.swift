//
//  PhotoTableViewCell.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    @IBOutlet private weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet private weak var titleLabelContainer: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        photoImageView.image = UIImage(named: "defaultImage")
    }
    
    func configure(with photo: Photo) {
        titleLabel.text = "Placeholder Title"
        photoImageView.loadImage(for: photo, size: .small)
    }
}
