//
//  NewCityViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/7/25.
//

import UIKit

final class NewCityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private var navigationBar: UINavigationItem!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var segment: UISegmentedControl!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet var textFieldBackground: UIView!
    
    private let cityList = CityInfo().city
    private var domesticList: [City] {
        cityList.filter { $0.domestic_travel }
    }
    private var overseasList: [City] {
        cityList.filter { !$0.domestic_travel }
    }
    private var segmentIndex: Int {
        segment.selectedSegmentIndex
    }
    private var filterList = [City]()
    private var isSearching: Bool {
        let text = textField.text ?? ""
        return !text.isEmpty
    }
    private var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: NewCityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: NewCityCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        configureLayout()
        configureSegmentUI()
        configureTextFieldUI()
        navigationBar.title = "인기 도시"
    }

    @IBAction func textFieldReturnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchText = text
        switch segmentIndex {
        case 1:
            filterList = filteringList(list: domesticList, text: text)
        case 2:
            filterList = filteringList(list: overseasList, text: text)
        default:
            filterList = filteringList(list: cityList, text: text)
        }
        collectionView.reloadData()
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        textFieldEditingChanged(textField)
        collectionView.reloadData()
    }
    
    private func filteringList(list: [City], text: String) -> [City] {
        let result = list.filter {
            $0.city_name.localizedCaseInsensitiveContains(text) ||
            $0.city_english_name.localizedCaseInsensitiveContains(text) ||
            $0.city_explain.localizedCaseInsensitiveContains(text)
        }
        return result
    }
    
    private func configureTextFieldUI() {
        textField.placeholder = "찾고 싶은 도시를 검색해 보세요"
        textField.borderStyle = .none
        textField.backgroundColor = .none
        textFieldBackground.backgroundColor = .systemGray6
        textFieldBackground.layer.cornerRadius = 12
    }
    
    private func configureSegmentUI() {
        segment.insertSegment(withTitle: "해외", at: 2, animated: true)
        segment.setTitle("모두", forSegmentAt: 0)
        segment.setTitle("국내", forSegmentAt: 1)
    }

    private func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 176, height: 262)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewCityCollectionViewCell.identifier, for: indexPath)
        guard let collectionCell = cell as? NewCityCollectionViewCell else { return cell }
        let item: City
        switch segmentIndex {
        case 1:
            item = isSearching ? filterList[indexPath.row] : domesticList[indexPath.row]
            collectionCell.configureData(item: item, searchText: searchText)
            return collectionCell
        case 2:
            item = isSearching ? filterList[indexPath.row] : overseasList[indexPath.row]
            collectionCell.configureData(item: item, searchText: searchText)
            return collectionCell
        default:
            item = isSearching ? filterList[indexPath.row] : cityList[indexPath.row]
            collectionCell.configureData(item: item, searchText: searchText)
            return collectionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentIndex {
        case 1:
            return isSearching ? filterList.count : domesticList.count
        case 2:
            return isSearching ? filterList.count : overseasList.count
        default:
            return isSearching ? filterList.count : cityList.count
        }
    }

}
