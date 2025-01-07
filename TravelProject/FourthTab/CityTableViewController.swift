//
//  CityTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/6/25.
//

import UIKit

final class CityTableViewController: UITableViewController {
    
    let cityList = CityInfo().city
    var domesticList: [City] {
        cityList.filter { $0.domestic_travel }
    }
    var overseasList: [City] {
        cityList.filter { !$0.domestic_travel }
    }
    var filterList = [City]()
    var segmentIndex = 0
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityTableViewCell.identifier)
        configureSegmentUI()
        configureSearchBar()
    }

    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        segmentIndex = sender.selectedSegmentIndex
        guard let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        if !searchText.isEmpty {
            updateSearchResults(for: searchController)
        }
        tableView.reloadData()
    }

    
    func configureSearchBar() {
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "찾고 싶은 도시를 입력해 주세요"
        searchController.searchResultsUpdater = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    
    func configureSegmentUI() {
        segment.setTitle("모두", forSegmentAt: 0)
        segment.setTitle("국내", forSegmentAt: 1)
        segment.setTitle("해외", forSegmentAt: 2)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath)
        guard let cityCell = cell as? CityTableViewCell else { return cell }
        let row: City
        
        switch segmentIndex {
        case 1:
            row = isFiltering ? filterList[indexPath.row] : domesticList[indexPath.row]
            cityCell.configureData(row: row)
            return cityCell
        case 2:
            row = isFiltering ? filterList[indexPath.row] : overseasList[indexPath.row]
            cityCell.configureData(row: row)
            return cityCell
        default:
            row = isFiltering ? filterList[indexPath.row] : cityList[indexPath.row]
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
            return isFiltering ? filterList.count : domesticList.count
        case 2:
            return isFiltering ? filterList.count : overseasList.count
        default:
            return isFiltering ? filterList.count : cityList.count
        }
    }

}

extension CityTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        switch segmentIndex {
        case 1:
            self.filterList = self.domesticList.filter { $0.city_name.localizedCaseInsensitiveContains(text) ||
                $0.city_english_name.localizedCaseInsensitiveContains(text) ||
                $0.city_explain.localizedCaseInsensitiveContains(text)
            }
        case 2:
            self.filterList = self.overseasList.filter { $0.city_name.localizedCaseInsensitiveContains(text) ||
                $0.city_english_name.localizedCaseInsensitiveContains(text) ||
                $0.city_explain.localizedCaseInsensitiveContains(text)
            }
        default:
            self.filterList = self.cityList.filter { $0.city_name.localizedCaseInsensitiveContains(text) ||
                $0.city_english_name.localizedCaseInsensitiveContains(text) ||
                $0.city_explain.localizedCaseInsensitiveContains(text)
            }
        }
        self.tableView.reloadData()
    }
}
