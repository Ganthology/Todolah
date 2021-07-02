//
//  ShowViewController.swift
//  Todolah
//
//  Created by Boon Kit Gan on 02/07/2021.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    var item: Item?
    
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
        
        if let safeItem = item {
            titleField.text = safeItem.title
            textView.text = safeItem.desc
            deadlinePicker.date = safeItem.deadline!
        }
        
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
