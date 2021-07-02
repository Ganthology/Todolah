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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTodoItem" {
            let destinationVC = segue.destination as! AddViewController
            destinationVC.status = categoryControl.titleForSegment(at: categoryControl.selectedSegmentIndex)
            destinationVC.completionHandler = { item in
                self.save(item: item)
                print(item.title)
                print(item.category)
                return item
            }
        }
    }
    
    func loadItems() {
        todoItems = realm.objects(Item.self)
        
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
        return todoItems?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem")!
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "Deadline: \(String(describing: item.deadline))"
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
        if tableView.allowsMultipleSelection {
            if let item = todoItems?[indexPath.row] {
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
        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let selectedItem = todoItems?[indexPath.row]
//
//        do {
//            try self.realm.write({
//                selectedItem?.isSelected = false
//            })
//        } catch {
//            print("Error saving edited isSelected property, \(error)")
//        }
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

