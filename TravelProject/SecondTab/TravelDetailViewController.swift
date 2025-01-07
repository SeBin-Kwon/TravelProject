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
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
    }
    
    @objc
    private func backButtonTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    private func configureUI() {
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 20
        titleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        subLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center
        subLabel.textAlignment = .center
        subLabel.numberOfLines = 0
        backButton.setTitle("다른 도시 보러가기", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.setTitleColor(.lightGray, for: .highlighted)
        backButton.backgroundColor = .adColor3
        backButton.layer.cornerRadius = backButton.bounds.height / 2
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureData() {
        let urlText =  travelImage ?? ""
        guard let url = URL(string: urlText) else { return }
        travelImageView.kf.setImage(with: url)
        titleLabel.text = titleText
        subLabel.text = subText
        navigationItem.title = "관광지 화면"
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = back
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

}
