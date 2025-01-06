//
//  CityTableViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/6/25.
//

import UIKit
import Kingfisher

class CityTableViewCell: UITableViewCell {
    
    static let identifier = "CityTableViewCell"
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet var blackBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        backgroundImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        backgroundImageView.layer.cornerRadius = 20
        blackBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        blackBackground.layer.cornerRadius = 20
        blackBackground.clipsToBounds = true
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .right
        subTitleLabel.textColor = .white
        subTitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func configureData(row: City) {
        titleLabel.text = row.title
        guard let url = URL(string: row.city_image) else { return }
        backgroundImageView.kf.setImage(with: url)
        subTitleLabel.text = row.city_explain
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
