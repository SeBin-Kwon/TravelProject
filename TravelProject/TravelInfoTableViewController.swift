//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewController: UITableViewController {
    
    @IBOutlet var navigationBar: UINavigationItem!
    var travelInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 134
        navigationBar.title = "도시 상세 정보"
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        guard travelInfo[sender.tag].like != nil else { return }
        travelInfo[sender.tag].like?.toggle()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoTableViewCell", for: indexPath)
        guard let travelInfoCell = cell as? TravelInfoTableViewCell else { return cell }
        let row = travelInfo[indexPath.row]
        
        let urlString = row.travel_image ?? ""
        guard let url = URL(string: urlString) else { return cell }
        travelInfoCell.travelImageView.kf.setImage(with: url)
        travelInfoCell.travelImageView.layer.cornerRadius = 10
        travelInfoCell.travelImageView.contentMode = .scaleAspectFill
        
        travelInfoCell.titleLabel.text = row.title
        travelInfoCell.titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        travelInfoCell.descriptionLabel.text = row.description
        travelInfoCell.descriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        travelInfoCell.descriptionLabel.textColor = .gray
        travelInfoCell.descriptionLabel.numberOfLines = 0
        
        travelInfoCell.gradeLabel.text = "별점 \(String(row.grade ?? 0.0))"
        travelInfoCell.gradeLabel.textColor = .systemGray2
        travelInfoCell.gradeLabel.font = .systemFont(ofSize: 12)
        
        let save = row.save?.formatted()
        travelInfoCell.saveLabel.text = " · 저장 \(save ?? "0")"
        travelInfoCell.saveLabel.textColor = .systemGray2
        travelInfoCell.saveLabel.font = .systemFont(ofSize: 12)
        
        travelInfoCell.likeButton.tag = indexPath.row
        travelInfoCell.likeButton.tintColor = .white
        travelInfoCell.likeButton.setImage(UIImage(systemName: row.like ?? false ? "heart.fill" : "heart"), for: .normal)
        travelInfoCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return travelInfoCell
    }
}
