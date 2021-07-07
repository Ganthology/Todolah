//
//  EditViewController.swift
//  Todolah
//
//  Created by Boon Kit Gan on 30/06/2021.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    var item: Item?
    var completionHandler: ((Item) -> Item)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textView.layer.borderWidth = 0.5
        textView.clipsToBounds = true
        
        // detect darkmode
        if traitCollection.userInterfaceStyle == .dark {
            textView.backgroundColor = .systemBackground
            textView.textColor = .placeholderText
        }
        
        // load item to the view
        if let safeItem = item {
            titleField.text = safeItem.title
            textView.text = safeItem.desc
            deadlinePicker.date = safeItem.deadline!
        }
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        let newItem = Item()
        newItem.title = titleField.text! == "" ? "No Title" : titleField.text!
        newItem.desc = textView.text == "Enter the description" ? "No Description" : textView.text
        newItem.deadline = deadlinePicker.date.floor(precision: 60)
        newItem.category = item!.category
        
        let _ = completionHandler?(newItem)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        let newItem = Item()
        newItem.title = titleField.text! == "" ? "No Title" : titleField.text!
        newItem.desc = textView.text == "Enter the description" ? "No Description" : textView.text
        newItem.deadline = deadlinePicker.date.floor(precision: 60)
        newItem.category = "Completed"
        
        let _ = completionHandler?(newItem)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Dismiss the keyboard when touching outside the textfield and textview
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
//MARK: - Text View delegate methods
extension EditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .label
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter the description"
            textView.textColor = .placeholderText
        }
    }
    
}

