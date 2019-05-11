//
//  ViewController.swift
//  Todoey
//
//  Created by Bradley Tudor on 5/11/19.
//  Copyright © 2019 Bradley Tudor. All rights reserved.
//

import UIKit

class TodoeyListViewController: UITableViewController {

    var itemArray = ["Find Milk", "Eat Tacos", "Destroy Camels"]
    var defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }
    
    //MARK - TABLE VIEW DATASOURCE METHODS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = cell?.accessoryType == .checkmark ? .none : .checkmark
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        
        var txtField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "" ,preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks add item
            self.itemArray.append(txtField.text ?? "new item")
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create New Item"
            txtField = textField
        }
        
        present(alert,animated: true, completion: nil)
        
    }
    
}

