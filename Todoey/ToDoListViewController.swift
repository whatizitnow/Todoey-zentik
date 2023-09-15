//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    
    var itemArray: [String] = []
    
    let defaults = UserDefaults.standard
        
    // newest test comment

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemArray = defaults.array(forKey:"ToDoItemArray") as? [String] ?? [String]()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
                
        content.text = itemArray[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    //MARK: Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   //     print(itemArray[indexPath.row])
        //testerno more
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }

    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new item to the list", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.itemArray.append(textField.text ?? "")
            
            self.defaults.set(self.itemArray, forKey: "ToDoItemArray")
            
            print(self.defaults.object(forKey: "ToDoItemArray") ?? "")
            
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

