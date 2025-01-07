//
//  ShoppingTableViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/5/25.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingTableViewCell"

    @IBOutlet private var cellBackground: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet private var shoppingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        shoppingLabel.font = .systemFont(ofSize: 14)
        shoppingLabel.numberOfLines = 0
        cellBackground.backgroundColor = .systemGray6
        cellBackground.layer.cornerRadius = 10
        checkButton.tintColor = .black
        favoriteButton.tintColor = .black
    }
    
    func configureData(row: Shopping) {
        shoppingLabel.text = row.title
        checkButton.setImage(UIImage(systemName: row.check ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        let mediumStar = UIImage(systemName: "star", withConfiguration: symbolConfig)
        let mediumStarFill = UIImage(systemName: "star.fill", withConfiguration: symbolConfig)
        favoriteButton.setImage(row.favorite ? mediumStarFill : mediumStar, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
