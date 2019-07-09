//
//  ToDoListViewController.swift
//  TodoApp
//
//  Created by Tuan Hoang Anh on 7/3/19.
//  Copyright © 2019 Tuan Hoang Anh. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController {
    
    var todoArray = [Item]()
    
    let filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filepath!)

       
      loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        let item = todoArray[indexPath.row]
        
        cell.textLabel?.text =  item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        todoArray[indexPath.row].done = !todoArray[indexPath.row].done
        tableView.reloadData()
        
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemPress(_ sender: Any) {
        var mTextField = UITextField()
        let  alert = UIAlertController(title: "Add to do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let a = mTextField.text
            {
                if a != ""
                {
                    let newitem = Item(context: self.context)
                    newitem.title = a
                    newitem.done = false
                    self.todoArray.append(newitem)
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: self.todoArray.count-1, section: 0), at: .bottom, animated: true)
                    self.saveData()
                }
            }
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter to do"
            mTextField = textfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func saveData(){
//        let encode = PropertyListEncoder()
//        do
//        {
//            let data =  try encode.encode(todoArray)
//            try data.write(to: self.filepath!)
//        }catch{
//            print("encode error \(error.localizedDescription)")
//        }
        do
        {
      try  context.save()
            
        } catch
        {
            print("Datacore error: \(error)  ")
        }
        
        
    }
    
    func loadData()
    {
//        let decode = PropertyListDecoder()
//        do
//        {
//            let data = try  Data(contentsOf: filepath!)
//            let decodeable = try decode.decode([Item].self, from: data)
//            todoArray = decodeable
//
//
//        } catch {
//            print(error.localizedDescription)
//        }
        do{
           // let request: NSFetchRequest<Item> = Item.fetchRequest()
       todoArray =  try context.fetch(Item.fetchRequest())
        }catch
        {
            print("error fetch data \(error)")
            
        }
        
        
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
