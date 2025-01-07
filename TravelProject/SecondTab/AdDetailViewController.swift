//
//  AdDetailViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/7/25.
//

import UIKit

final class AdDetailViewController: UIViewController {
    
    static let identifier = "AdDetailViewController"
    var adText: String?
    @IBOutlet var adLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        adLabel.text = adText
        adLabel.font = .systemFont(ofSize: 25, weight: .bold)
        adLabel.textAlignment = .center
        adLabel.numberOfLines = 0
        navigationItem.title = "광고 화면"
        let close = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem = close
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
