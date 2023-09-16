//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
        
    var newArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
        
        if let itemArray = defaults.array(forKey: K.ArrayIdentifier) as? [Item] {
            
            newArray = itemArray
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        let item = newArray[indexPath.row]
                
        content.text = item.title
        
        cell.contentConfiguration = content
        
        cell.accessoryType = item.done ? .checkmark : .none

        
        return cell
        
    }
    
    //MARK: Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //toggle the reverse using '!' before value
        newArray[indexPath.row].done = !newArray[indexPath.row].done
        
        saveItems()
        
        tableView.reloadData()


    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new item to the list", message: "", preferredStyle: .alert)
        
    

        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text ?? ""
            self.newArray.append(newItem)
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Type it out"
            
            textField = alertTextField

            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)


    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        
        do {
            
            let data = try encoder.encode(self.newArray)
            try data.write(to: self.dataFilePath!)
            
        } catch {
            print("Error encoding item array")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
            do {
                let data = try Data(contentsOf: dataFilePath!)
                
                let decoder = PropertyListDecoder()

                newArray = try PropertyListDecoder().decode([Item].self, from: data)
            
            } catch {
                print("Can't retrieve data")
            }
    }


}

