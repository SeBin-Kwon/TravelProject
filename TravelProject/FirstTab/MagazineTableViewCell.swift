//
//  MagazineTableViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {
    
    static let identifier = "MagazineTableViewCell"
    
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 15
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        subTitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        subTitleLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .gray
    }
    
    func configureData(row: Magazine) {
        guard let url = URL(string: row.photo_image) else { return }
        photoImageView.kf.setImage(with: url)
        titleLabel.text = row.title
        subTitleLabel.text = row.subtitle
        dateLabel.text = dateFormatted(row)
    }
    
    private func dateFormatted(_ row: Magazine) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
        let date = format.date(from: row.date)
        format.dateFormat = "yy년 MM월 dd일"
        return format.string(from: date ?? Date())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
