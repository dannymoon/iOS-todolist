//
//  AddItemVC.swift
//  TodoList
//
//  Created by Danny Moon on 11/14/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController{
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var descArea: UITextView!
    @IBOutlet weak var date: UIDatePicker!
    
    weak var delegate: AddItemDelegate?
    @IBAction func addButtonPressed(_ sender: UIButton){
        let title = titleLabel.text!
        let desc = descArea.text!
        let d = date.date
        
        if title != "" && desc != "" {
            delegate?.addItem(title, desc, d, sender: self)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

}

