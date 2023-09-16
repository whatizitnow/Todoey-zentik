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
//        Item(title: "New beans", done: false),
//        Item(title: "Old face", done: false),
//        Item(title: "Happy always", done: false)
    
    

    
    let defaults = UserDefaults.standard
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newitem1 = Item()
        newitem1.title = "Test 1"
        newArray.append(newitem1)
        
        let newitem2 = Item()
        newitem2.title = "Test 2"
        newArray.append(newitem2)
        
        let newitem3 = Item()
        newitem3.title = "Test 3"
        newArray.append(newitem3)
        
       // newArray = defaults2.array(forKey: K.ArrayIdentifier) as? [Item] ?? [Item]()

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
        
        tableView.reloadData()


    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new item to the list", message: "", preferredStyle: .alert)
        
    

        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text ?? ""
            self.newArray.append(newItem)
            
            self.defaults.set(self.newArray, forKey: K.ArrayIdentifier)
                        
            self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Type it out"
            
            textField = alertTextField

            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)


    }
    



}

