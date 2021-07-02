//
//  AddViewController.swift
//  Todolah
//
//  Created by Boon Kit Gan on 30/06/2021.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    let realm = try! Realm()
    
    var status: String?
    var completionHandler: ((Item) -> Item)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textView.layer.borderWidth = 0.5
        textView.clipsToBounds = true
        
        if traitCollection.userInterfaceStyle == .dark {
            textView.backgroundColor = .systemBackground
            textView.textColor = .placeholderText
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = 0
        
        deadlinePicker.minimumDate = Calendar.current.date(byAdding: dateComponents, to: Date())
    }

    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        let newItem = Item()
        newItem.title = titleField.text ?? "No Title"
        newItem.desc = textView.text ?? "No Description"
        newItem.deadline = deadlinePicker.date
        newItem.category = status ?? "pending"
        
        let _ = completionHandler?(newItem)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
