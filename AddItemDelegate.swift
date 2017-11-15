//
//  AddItemDelegate.swift
//  TodoList
//
//  Created by Danny Moon on 11/14/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit


protocol AddItemDelegate: class {
    func addItem(_ title: String, _ desc: String, _ date: Date, sender: UIViewController)
}
