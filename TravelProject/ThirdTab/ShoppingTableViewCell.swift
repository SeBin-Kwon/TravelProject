//
//  ShoppingTableViewCell.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/5/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet var cellBackground: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var shoppingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
