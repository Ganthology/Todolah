//
//  ViewController.swift
//  Todolah
//
//  Created by Boon Kit Gan on 27/06/2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryControl: UISegmentedControl!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var cancelToolbarItem: UIBarButtonItem!
    
    let realm = try! Realm()
    
    var todoItems: Results<Item>?
    var categoryItems: Results<Item>?
    
    var senderItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.allowsMultipleSelectionDuringEditing = true

        toolbar.isHidden = true
//        let item = toolbar.items?[0]
//
//        item?.isEnabled = false
        
        cancelToolbarItem.tintColor = .red
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        loadItems()

        //print(todoItems?.count)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        loadItems()
//    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addTodoItem", sender: self)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        // hide toolbar when cancel button is pressed
        toolbar.isHidden = true
        // end Editing mode when cancel button is pressed
        tableView.setEditing(false, animated: true)
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editTodoItem", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTodoItem" {
            let destinationVC = segue.destination as! AddViewController
            destinationVC.status = categoryControl.titleForSegment(at: categoryControl.selectedSegmentIndex)
            destinationVC.completionHandler = { item in
                self.save(item: item)
//                print(item.title)
//                print(item.category)
                return item
            }
        } else if segue.identifier == "showTodoItem" {
            let destinationVC = segue.destination as! ShowViewController
            if let safeItem = senderItem {
                destinationVC.item = safeItem
            }
        } else if segue.identifier == "editTodoItem" {
            let destinationVC = segue.destination as! EditViewController
            if let safeItem = senderItem {
                destinationVC.item = safeItem
            }
            destinationVC.completionHandler = { item in
                do {
                    try self.realm.write {
                        self.senderItem?.title = item.title
                        self.senderItem?.desc = item.desc
                        self.senderItem?.category = item.category
                        self.senderItem?.deadline = item.deadline
                    }
                    // Changed
//                    self.tableView.reloadData()
                    self.loadItems()
                } catch {
                    print("Error updating edited item, \(error)")
                }
                return item
            }
        }
    }
    
    @IBAction func categoryControlButtonClicked(_ sender: UISegmentedControl) {
        loadItems()
    }
    func loadCategoryItems() {
        categoryItems = todoItems?.filter("category CONTAINS %@", categoryControl.titleForSegment(at: categoryControl.selectedSegmentIndex)!)
    }
    
    func loadItems() {
        todoItems = realm.objects(Item.self)
        //loadCategoryItems()
        categoryItems = todoItems?.filter("category CONTAINS %@", categoryControl.titleForSegment(at: categoryControl.selectedSegmentIndex)!)
        tableView.reloadData()
    }
    
    func save(item: Item) {
        do {
            try realm.write({
                realm.add(item)
            })
        } catch {
            print("Error saving new item, \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - TableView Data Source methods
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = categoryItems {
            if items.count == 0 {
                // when the list is empty
                return 1
            }
            return items.count
        } else {
            // when the list is nil
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        // display when the list is empty
        if categoryItems?.count == 0 {
            cell.textLabel?.text = "No items to display. Please press \"+\" to add new items."
            cell.detailTextLabel?.text = ""
            return cell
        }
        
        if let item = categoryItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "Deadline: \(dateFormatter.string(from: item.deadline!))"
        } else {
            cell.textLabel?.text = "No items to display. Please press \"+\" to add new items."
            cell.detailTextLabel?.text = ""
        }
                    
        return cell
    }
}

//MARK: - TableView Delegate methods
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            print("is editing")
            if let item = todoItems?[indexPath.row] {
                senderItem = item
                do {
                    try realm.write({
                        item.isSelected = !item.isSelected
                    })
                } catch {
                    print("Error updating isSelected property, \(error)")
                }
            }
        } else {
            print("Going to show details of item")
            print("\(indexPath)")
            // direct to show view controller
            if let item = todoItems?[indexPath.row] {
                senderItem = item
                performSegue(withIdentifier: "showTodoItem", sender: self)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write({
                        item.isSelected = !item.isSelected
                    })
                } catch {
                    print("Error updating isSelected property, \(error)")
                }
            }
        }
    }
    
    // detect pan gesture, start multiple selection
    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        if let _ = todoItems?[indexPath.row] {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        if let _ = todoItems?[indexPath.row] {
            tableView.setEditing(true, animated: true)
            toolbar.isHidden = false
        }
    }

}

