//
//  UILabel+Extension.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/8/25.
//

import UIKit

extension String {
    func highlightText(target: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: target, options: .caseInsensitive)
        attributedString.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: range)
        return attributedString
    }
}
