//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewController: UITableViewController {
    
    @IBOutlet var navigationBar: UINavigationItem!
    var travelInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationBar.title = "도시 상세 정보"
        navigationBar.backBarButtonItem = nil
    }
    
    @objc
    private func likeButtonTapped(_ sender: UIButton) {
        guard travelInfo[sender.tag].like != nil else { return }
        travelInfo[sender.tag].like?.toggle()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = travelInfo[indexPath.row]
        switch row.ad {
        case true:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: AdDetailViewController.identifier) as? AdDetailViewController else { return }
            vc.adText = row.title
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .crossDissolve
            present(nav, animated: true)
        case false:
            guard let vc = storyboard?.instantiateViewController(withIdentifier: TravelDetailViewController.identifier) as? TravelDetailViewController else { return }
            vc.titleText = row.title
            vc.subText = row.description
            vc.travelImage = row.travel_image
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = travelInfo[indexPath.row]
        let cell: UITableViewCell
        switch row.ad {
        case true:
        cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath)
        guard let adCell = cell as? AdTableViewCell else { return cell }
        adCell.configureData(row: row)
        return adCell
            
        case false:
        cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier, for: indexPath)
        guard let travelInfoCell = cell as? TravelInfoTableViewCell else { return cell }
        travelInfoCell.configureData(row: row)
        travelInfoCell.likeButton.tag = indexPath.row
        travelInfoCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return travelInfoCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return travelInfo[indexPath.row].ad ? 90 : 134
    }
}
