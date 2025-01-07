//
//  TravelDetailViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/7/25.
//

import UIKit
import Kingfisher

class TravelDetailViewController: UIViewController {
    
    static let identifier = "TravelDetailViewController"
    var travelImage: String?
    var titleText: String?
    var subText: String?
    
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    @objc
    private func backButtonTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    private func configureData() {
        let urlText =  travelImage ?? ""
        guard let url = URL(string: urlText) else { return }
        travelImageView.kf.setImage(with: url)
        titleLabel.text = titleText
        subLabel.text = subText
        navigationItem.title = "관광지 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

}
