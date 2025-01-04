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
        let row = travelInfo[indexPath.row]
        let cell: UITableViewCell
        if row.ad {
            cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath)
            guard let adCell = cell as? AdTableViewCell else { return cell }
            configureAdCellUI(cell: adCell, row: row)
            
            return adCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoTableViewCell", for: indexPath)
            guard let travelInfoCell = cell as? TravelInfoTableViewCell else { return cell }

            let urlString = row.travel_image ?? ""
            guard let url = URL(string: urlString) else { return cell }
            travelInfoCell.travelImageView.kf.setImage(with: url)
            configureTravelInfoCellUI(cell: travelInfoCell, row: row)
            travelInfoCell.likeButton.tag = indexPath.row
            travelInfoCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return travelInfoCell
        }
    }
    
    func configureAdCellUI(cell: AdTableViewCell, row: Travel) {
        cell.adLabel.text = row.title
        cell.adLabel.numberOfLines = 0
        cell.adLabel.textAlignment = .center
        cell.adLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        switch row.title {
        case let title where title.contains("하와이"):
            cell.backgroundColor = UIColor(named: "adColor1")
        case let title where title.contains("도쿄"):
            cell.backgroundColor = UIColor(named: "adColor2")
        case let title where title.contains("제주"):
            cell.backgroundColor = UIColor(named: "adColor3")
        default:
            cell.backgroundColor = UIColor(named: "adColor1")
        }

        cell.adBadge.textAlignment = .center
        cell.adBadge.backgroundColor = .white
        cell.adBadge.clipsToBounds = true
        cell.adBadge.layer.cornerRadius = 8
        cell.adBadge.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    func configureTravelInfoCellUI(cell: TravelInfoTableViewCell, row: Travel) {
        cell.travelImageView.layer.cornerRadius = 10
        cell.travelImageView.contentMode = .scaleAspectFill
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        cell.descriptionLabel.text = row.description
        cell.descriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        cell.descriptionLabel.textColor = .gray
        cell.descriptionLabel.numberOfLines = 0
        
        cell.gradeLabel.text = "별점 \(String(row.grade ?? 0.0))"
        cell.gradeLabel.textColor = .systemGray2
        cell.gradeLabel.font = .systemFont(ofSize: 12)
        
        cell.saveLabel.text = " · 저장 \(row.save?.formatted() ?? "0")"
        cell.saveLabel.textColor = .systemGray2
        cell.saveLabel.font = .systemFont(ofSize: 12)
        
        cell.likeButton.tintColor = .white
        cell.likeButton.setImage(UIImage(systemName: row.like ?? false ? "heart.fill" : "heart"), for: .normal)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return travelInfo[indexPath.row].ad ? 90 : 134
    }
}
