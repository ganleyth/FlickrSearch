//
//  Section.swift
//  FlickrSearch
//
//  Created by Thomas Ganley on 9/29/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class Section: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Subclass must implement this method.")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Subclass must implement this method.")
    }
}
