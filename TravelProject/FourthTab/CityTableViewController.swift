//
//  CityTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/6/25.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    let cityList = CityInfo().city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityTableViewCell.identifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count   
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath)
        guard let cityCell = cell as? CityTableViewCell else { return cell }
        let row = cityList[indexPath.row]
        cityCell.configureData(row: row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
