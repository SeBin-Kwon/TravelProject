//
//  AdTableViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    static let identifier = "AdTableViewCell"
    
    @IBOutlet private var adLabel: UILabel!
    @IBOutlet private var adBadge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        adLabel.numberOfLines = 0
        adLabel.textAlignment = .center
        adLabel.font = .systemFont(ofSize: 15, weight: .bold)
        adBadge.textAlignment = .center
        adBadge.backgroundColor = .white
        adBadge.clipsToBounds = true
        adBadge.layer.cornerRadius = 8
        adBadge.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    func configureData(row: Travel) {
        adLabel.text = row.title
        switch row.title {
        case let title where title.contains("하와이"):
            backgroundColor = UIColor(named: "adColor1")
        case let title where title.contains("도쿄"):
            backgroundColor = UIColor(named: "adColor2")
        case let title where title.contains("제주"):
            backgroundColor = UIColor(named: "adColor3")
        default:
            backgroundColor = UIColor(named: "adColor1")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
