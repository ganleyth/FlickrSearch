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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = nil
        contentView.backgroundColor = .appDarkerGrey
        configureSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        photoImageView.image = UIImage(named: "defaultImage")
        titleLabelContainer.isHidden = false
    }
    
    func configure(with photo: Photo) {
        if !photo.title.isEmpty {
            titleLabel.text = photo.title
        } else {
            titleLabelContainer.isHidden = true
        }
        photoImageView.loadImage(for: photo, size: .small)
    }
    
    private func configureSubviews() {
        // Image view
        photoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        photoImageView.layer.cornerRadius = 8.0
        
        // Title label container
        titleLabelContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        titleLabelContainer.layer.cornerRadius = 16.0
        titleLabelContainer.backgroundColor = .appDarkGrey
        
        // Title label
        titleLabel.textColor = .appTextAlmostWhite
    }
}
