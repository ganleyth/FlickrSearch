//
//  PhotoDetailViewController.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

final class PhotoDetailViewController: UIViewController {
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var photo: Photo? {
        didSet {
            if isViewLoaded {
                setUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        guard let photo = photo else { return }
        titleLabel.text = photo.title
        photoImageView.loadImage(for: photo, size: .medium)
        
        titleLabel.textColor = .appTextAlmostWhite
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
