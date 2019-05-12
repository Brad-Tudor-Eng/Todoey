//
//  ViewController.swift
//  Todoey
//
//  Created by Bradley Tudor on 5/11/19.
//  Copyright © 2019 Bradley Tudor. All rights reserved.
//

import UIKit

class TodoeyListViewController: UITableViewController {

    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    var dataFilePath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let newItem = Item()
        newItem.title = "Destroy Camels"
        
        itemArray.append(newItem)
        
        loadItems()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath) {
            let decoder = PropertyListDecoder()
            do{
                 itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("decoder broke \(error)")
            }
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
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].checked ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        
        self.tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        
        var txtField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "" ,preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when the user clicks add item
            let newItem = Item()
            
            newItem.title = txtField.text ?? ""
            
            self.itemArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            
            do{
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath)
            }catch{
                print("Error encoding item array \(error)")
            }
            
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

