//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Vu Nguyen on 6/15/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    var categories = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
           cell.textLabel?.text = categories[indexPath.row].name
           
           return cell
           
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       }



    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFiled = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textFiled.text!
            self.categories.append(newCategory)
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textFiled = field
            textFiled.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func loadCategories(){
        
    }
    
    func save(category: Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
                print ("Fail to write to realm")
        }
        tableView.reloadData()
    }
}
