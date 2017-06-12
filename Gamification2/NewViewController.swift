//
//  NewViewController.swift
//  Gamification2
//
//  Created by New User on 6/12/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import UIKit
import CoreData

class NewViewController: UIViewController
{
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gameDesc: UITextField!
    @IBOutlet weak var output: UILabel!
    
    
    
    //NSManageObject
    //this can be used thruout the CLASS
    //very useful to call in here
    var context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    //This shows if the user wants to save the game as a Long Term or Short Term for their game
    @IBAction func `switch`(_ sender: UISwitch)
    {
        if (sender.isOn == true)
            {
                output.text = "Long Term"
            }
        else
            {
                output.text = "Short Term"
            }
    }
    
    
    
    
    
    
    
    
    
    //custom save function for context
    func save()
    {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any)
    {
        //if the textfields are not empty
        if gameName.text != ""
        {
            let newGame = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context)
            newGame.setValue(self.gameName!.text, forKey: "gameName")
            newGame.setValue(self.gameDesc!.text, forKey: "gameDesc")
            
            // call the custom save function
            save()
            
            //erase the name after the save button is clicked
            gameName.text = ""; gameDesc.text = ""
            
            //dimiss the keyboard
            gameName.resignFirstResponder(); gameDesc.resignFirstResponder()
        } else
        {
            print("Please Enter a GAME name")
        }
    }
    
    //dismiss the keyboard when clicked around the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
}
