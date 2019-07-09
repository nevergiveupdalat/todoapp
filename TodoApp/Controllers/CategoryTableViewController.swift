//
//  CategoryTableViewController.swift
//  TodoApp
//
//  Created by Tuan Hoang Anh on 7/9/19.
//  Copyright © 2019 Tuan Hoang Anh. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {

    var mlist = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
loaddata()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: - Add new categories
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
            var mtextField = UITextField()
        alert.addTextField { (textField) in
            textField.attributedPlaceholder = NSAttributedString(string: "enter category name")
            mtextField = textField
        }
        let alertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newcatitem = Category(context: self.context)
            newcatitem.name = mtextField.text
            self.mlist.append(newcatitem)
            self.tableView.reloadData()
            self.save()
            
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    //MARK: -TableView datasource method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mlist.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        let item = mlist[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToList"
        {
            let vc =  segue.destination as! ToDoListViewController
            if let indexPath = tableView.indexPathForSelectedRow{
            vc.category = mlist[indexPath.row]
            }
        }
    }
    
    
    func save()
    {
        do{
            try context.save()
        }catch{
            print("save data error: \(error)")
        }
    }
    
    func loaddata()
    {
        do{
        mlist = try context.fetch(Category.fetchRequest())
        }catch
        {
            print("error read coredata: \(error)")
        }
        
    }
    
    
    
    
    
    
}
