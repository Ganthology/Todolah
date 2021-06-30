//
//  AddViewController.swift
//  Todolah
//
//  Created by Boon Kit Gan on 30/06/2021.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
