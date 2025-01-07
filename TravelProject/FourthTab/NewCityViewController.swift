//
//  NewCityViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/7/25.
//

import UIKit

class NewCityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private var navigationBar: UINavigationItem!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var segment: UISegmentedControl!
    @IBOutlet private var collectionView: UICollectionView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let xib = UINib(nibName: NewCityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: NewCityCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        configureLayout()
        configureSegmentUI()
        navigationBar.title = "인기 도시"
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    }
    
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        print(segmentIndex)
        collectionView.reloadData()
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
        switch segmentIndex {
        case 1:
            collectionCell.configureData(item: domesticList[indexPath.row])
            return collectionCell
        case 2:
            collectionCell.configureData(item: overseasList[indexPath.row])
            return collectionCell
        default:
            collectionCell.configureData(item: cityList[indexPath.row])
            return collectionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
