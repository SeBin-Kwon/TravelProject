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
    
//    var shoppingList = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderUI()
        configureCellUI()
        tableView.rowHeight = 65
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath)
        guard let shoppingCell = cell as? ShoppingTableViewCell else { return cell }
//        shoppingCell.favoriteButton.tintColor = .black
        
        return shoppingCell
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
        addButton.layer.cornerRadius = 10
    }
    
    func configureCellUI() {
//        favoritesButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

}
