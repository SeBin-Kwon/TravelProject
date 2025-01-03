//
//  MagazineTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {

    let magazines = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 450
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath)
        let magazineCell = cell as? MagazineTableViewCell
        guard let magazineCell else { return cell }
        
        let magazine = magazines[indexPath.row]
        guard let url = URL(string: magazine.photo_image) else { return cell }
        magazineCell.photoImageView.kf.setImage(with: url)
        magazineCell.photoImageView.contentMode = .scaleAspectFill
        magazineCell.photoImageView.layer.cornerRadius = 15
        return cell
    }

}
