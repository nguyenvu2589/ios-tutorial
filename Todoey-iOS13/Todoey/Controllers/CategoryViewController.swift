//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vu Nguyen on 6/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    
    //Mark: - Tableview Datasource Methods
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

    
    //Mark: - Data Manipulation Methods
    func save(category: Category) {
       
    }
    
    func loadCategories() {
        
    }
    
    
    //Mark: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    
    
}
