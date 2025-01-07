//
//  NewCityCollectionViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/7/25.
//

import UIKit
import Kingfisher

final class NewCityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewCityCollectionViewCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage(systemName: "photo.badge.exclamationmark")
    }
    
    private func configureUI() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textAlignment = .center
        explainLabel.font = .systemFont(ofSize: 13, weight: .medium)
        explainLabel.textAlignment = .center
        explainLabel.numberOfLines = 0
        explainLabel.textColor = .gray
    }
    
    func configureData(item: City, searchText: String) {
        guard let url = URL(string: item.city_image) else { return }
        imageView.kf.setImage(with: url)
        titleLabel.text = item.title
        explainLabel.text = item.city_explain
        titleLabel.attributedText = item.title.highlightText(target: searchText)
        explainLabel.attributedText = item.city_explain.highlightText(target: searchText)
    }

}
