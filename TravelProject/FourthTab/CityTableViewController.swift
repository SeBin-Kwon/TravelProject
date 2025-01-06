//
//  CityTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/6/25.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    let cityList = CityInfo().city
    var domesticList: [City] {
        cityList.filter { $0.domestic_travel }
    }
    var overseasList: [City] {
        cityList.filter { !$0.domestic_travel }
    }
    var segmentIndex = 0
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityTableViewCell.identifier)
        configureHeaderUI()
    }

    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        segmentIndex = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    
    func configureHeaderUI() {
        segment.setTitle("모두", forSegmentAt: 0)
        segment.setTitle("국내", forSegmentAt: 1)
        segment.setTitle("해외", forSegmentAt: 2)
        searchBar.searchBarStyle = .minimal
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath)
        guard let cityCell = cell as? CityTableViewCell else { return cell }
        let row: City
        
        switch segmentIndex {
        case 1:
            row = domesticList[indexPath.row]
            cityCell.configureData(row: row)
            return cityCell
        case 2:
            row = overseasList[indexPath.row]
            cityCell.configureData(row: row)
            return cityCell
        default:
            row = cityList[indexPath.row]
            cityCell.configureData(row: row)
            return cityCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentIndex {
        case 1:
            return domesticList.count
        case 2:
            return overseasList.count
        default:
            return cityList.count
        }
    }

}
