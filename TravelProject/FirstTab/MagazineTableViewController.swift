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
        navigationItem.title = "SeSAC TRAVEL"
        tableView.rowHeight = (screen()?.bounds.height ?? 100) * 0.55
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
        
        magazineCell.titleLabel.text = magazine.title
        magazineCell.titleLabel.numberOfLines = 0
        magazineCell.titleLabel.font = .systemFont(ofSize: 22, weight: .bold) //1513
        
        magazineCell.subTitleLabel.text = magazine.subtitle
        magazineCell.subTitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        magazineCell.subTitleLabel.textColor = .gray
        
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
        let date = format.date(from: magazine.date)
        format.dateFormat = "yy년 MM월 dd일"
        magazineCell.dateLabel.text = format.string(from: date ?? Date())
        magazineCell.dateLabel.font = .systemFont(ofSize: 13)
        magazineCell.dateLabel.textColor = .gray
        
        return cell
    }

}
