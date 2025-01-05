//
//  ShoppingTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var textFieldBackground: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingList = [Shopping]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderUI()
        tableView.rowHeight = 56
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = textField.text else { return }
        let item = Shopping(title: text, check: false, favorite: false)
        shoppingList.append(item)
        view.endEditing(true)
    }
    
    @objc
    func checkButtonTapped(_ sender: UIButton) {
        shoppingList[sender.tag].check.toggle()
        let check = shoppingList[sender.tag].check
        sender.setImage(UIImage(systemName: check ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        print(check)
    }
    
    @objc
    func favoriteButtonTapped(_ sender: UIButton) {
        shoppingList[sender.tag].favorite.toggle()
        let favorite = shoppingList[sender.tag].favorite
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        let mediumStar = UIImage(systemName: "star", withConfiguration: symbolConfig)
        let mediumStarFill = UIImage(systemName: "star.fill", withConfiguration: symbolConfig)
        sender.setImage(favorite ? mediumStarFill : mediumStar, for: .normal)
        print(favorite)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath)
        guard let shoppingCell = cell as? ShoppingTableViewCell else { return cell }
        let row = shoppingList[indexPath.row]
        configureCellUI(cell: shoppingCell, row: row)
        
        shoppingCell.checkButton.tag = indexPath.row
        shoppingCell.favoriteButton.tag = indexPath.row
        
        shoppingCell.checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        shoppingCell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        return shoppingCell
    }
    
    func configureCellUI(cell: ShoppingTableViewCell, row: Shopping) {
        cell.shoppingLabel.text = row.title
        cell.shoppingLabel.font = .systemFont(ofSize: 14)
        
        cell.cellBackground.backgroundColor = .systemGray6
        cell.cellBackground.layer.cornerRadius = 10
        
        cell.checkButton.tintColor = .black
        cell.favoriteButton.tintColor = .black
    }
    
    func configureHeaderUI() {
        navigationBar.title = "쇼핑"
        textFieldBackground.backgroundColor = .systemGray6
        textFieldBackground.layer.cornerRadius = 10
        
        textField.borderStyle = .none
        textField.placeholder = "무엇을 구매하실 건가요?"
        textField.backgroundColor = .clear
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.setTitleColor(.darkGray, for: .highlighted)
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 8
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

}
