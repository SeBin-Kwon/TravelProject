//
//  MagazineTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit

final class MagazineTableViewController: UITableViewController {

    let magazines = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SeSAC TRAVEL"
        tableView.rowHeight = (screen()?.bounds.height ?? 100) * 0.55
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath)
        let magazineCell = cell as? MagazineTableViewCell
        guard let magazineCell else { return cell }
        let row = magazines[indexPath.row]
        magazineCell.configureData(row: row)
        return magazineCell
    }

}
