//
//  CategoryViewController.swift
//  Gamification2
//
//  Created by New User on 6/12/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var category_1: UITextField!
    @IBOutlet weak var category_2: UITextField!
    @IBOutlet weak var category_3: UITextField!
    @IBOutlet weak var category_4: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //needed to dismiss the keyboard when pressed return
        self.category_1.delegate = self; self.category_2.delegate = self; self.category_3.delegate = self; self.category_4.delegate = self;
    }
    
    //dismiss the keyboard when clicked around the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    //when pressed the return key, keyboard dismisses
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        category_1.resignFirstResponder(); category_2.resignFirstResponder(); category_3.resignFirstResponder(); category_4.resignFirstResponder();
        
        return true
    }
    
    
}
