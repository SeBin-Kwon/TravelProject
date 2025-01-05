//
//  ShoppingTableViewController.swift
//  TravelProject
//
//  Created by Sebin Kwon on 1/4/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var textFieldBackground: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingList = [Shopping]() {
        didSet {
            if !tableView.isEditing {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        configureHeaderUI()
        tableView.rowHeight = 56
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard !text.isEmpty else { return }
        let item = Shopping(title: text, check: false, favorite: false)
        shoppingList.append(item)
        textField.text = ""
        view.endEditing(true)
    }
    
    @objc
    func checkButtonTapped(_ sender: UIButton) {
        shoppingList[sender.tag].check.toggle()
    }
    
    @objc
    func favoriteButtonTapped(_ sender: UIButton) {
        shoppingList[sender.tag].favorite.toggle()
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { return .delete }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func configureCellUI(cell: ShoppingTableViewCell, row: Shopping) {
        cell.shoppingLabel.text = row.title
        cell.shoppingLabel.font = .systemFont(ofSize: 14)
        cell.shoppingLabel.numberOfLines = 0
        
        cell.cellBackground.backgroundColor = .systemGray6
        cell.cellBackground.layer.cornerRadius = 10
        
        cell.checkButton.tintColor = .black
        cell.checkButton.setImage(UIImage(systemName: row.check ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        
        cell.favoriteButton.tintColor = .black
        let symbolConfig = UIImage.SymbolConfiguration(scale: .medium)
        let mediumStar = UIImage(systemName: "star", withConfiguration: symbolConfig)
        let mediumStarFill = UIImage(systemName: "star.fill", withConfiguration: symbolConfig)
        cell.favoriteButton.setImage(row.favorite ? mediumStarFill : mediumStar, for: .normal)
    }
    
    func configureHeaderUI() {
        navigationBar.title = "쇼핑"
        textFieldBackground.backgroundColor = .systemGray6
        textFieldBackground.layer.cornerRadius = 10
        
        textField.borderStyle = .none
        textField.placeholder = "구매할 물건을 20자 이내로 작성해 주세요."
        textField.backgroundColor = .clear
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.setTitleColor(.darkGray, for: .highlighted)
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 8
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if text.count + string.count > 20 { return false }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    @IBAction func textFieldReturnKeyTapped(_ sender: UITextField) {

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

}
