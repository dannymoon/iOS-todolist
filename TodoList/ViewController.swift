//
//  ViewController.swift
//  TodoList
//
//  Created by Danny Moon on 11/13/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableData: [TodoItem] = []
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = getItems()
        tableView.reloadData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
        // Do any additional setup after loading the view, typically from a nib.


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            let dest = segue.destination as! AddItemVC
            dest.delegate = self
        }
    }
    
    func getItems() -> [TodoItem]{
        do {
            let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItem")
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            // downcast the results as an array of AwesomeEntity objects
            return results as! [TodoItem]
            // print the details of each item
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        return []

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
        let toDoItem = tableData[indexPath.row]
        cell.titleLable.text = toDoItem.title
        
        let date = toDoItem.date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateStr = dateFormatter.string(from: date)
        cell.dateLabel.text = dateStr
        cell.descLabel.text = toDoItem.desc
        
        if toDoItem.complete {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.row].complete {
            tableData[indexPath.row].complete = false
        } else {
            tableData[indexPath.row].complete = true
        }
        delegate.saveContext()
        tableView.reloadData()
    }
}


extension ViewController: AddItemDelegate{
    func addItem(_ title: String, _ desc: String, _ date: Date, sender: UIViewController) {
        
        
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "TodoItem", into: managedObjectContext) as! TodoItem
        item.title = title
        item.desc = desc
        item.date = date
        
        tableData.append(item)
        print(tableData)
        delegate.saveContext()
        tableView.reloadData()
        sender.dismiss(animated: true, completion: nil)
    }
    
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
