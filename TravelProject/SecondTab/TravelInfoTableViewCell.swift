//
//  TravelInfoTableViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit

class TravelInfoTableViewCell: UITableViewCell {
    
    static let identifier = "TravelInfoTableViewCell"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var travelImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet private var gradeLabel: UILabel!
    @IBOutlet private var saveLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        travelImageView.image = UIImage(systemName: "photo.badge.exclamationmark")
    }
    
    private func configureUI() {
        travelImageView.layer.cornerRadius = 10
        travelImageView.contentMode = .scaleAspectFill
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        gradeLabel.textColor = .systemGray2
        gradeLabel.font = .systemFont(ofSize: 12)
        saveLabel.textColor = .systemGray2
        saveLabel.font = .systemFont(ofSize: 12)
        likeButton.tintColor = .white
    }
    
    func configureData(row: Travel) {
        let urlString = row.travel_image ?? ""
        guard let url = URL(string: urlString) else { return }
        travelImageView.kf.setImage(with: url)
        titleLabel.text = row.title
        descriptionLabel.text = row.description
        gradeLabel.text = row.gradeText
        saveLabel.text = row.saveText
        likeButton.setImage(UIImage(systemName: row.like ?? false ? "heart.fill" : "heart"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
