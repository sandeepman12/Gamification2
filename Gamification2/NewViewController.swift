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
    //variables
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gameDesc: UITextField!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var inputWarning: UILabel!

    // this is required to save the data to the phone
    // references the ".viewContext" method in the AppDelegat Class
    var context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    //custom save function for context using the "context" reference variable
    func save()
    {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
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

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //This is what happens when the "save" button is clicked in the "Main.storyboard"
    @IBAction func saveButton(_ sender: Any)
    {
        
        
        //if the textfields ("gameName") is not empty, this happens
        if gameName.text != ""
        {
            //reference a variable to an ENTITY in the "Gamification2.xcdatamodeld"
            let newGame = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context)
            
            //sets the attributes in the "Gamification2.xcdatamodeld" for the "Game" ENTITY
            /*
             attributes: "gameName" & "gameDesc"
             */
            
            newGame.setValue(self.gameName!.text, forKey: "gameName")
            newGame.setValue(self.gameDesc!.text, forKey: "gameDesc")
            
            // calls the custom save function to save data to the phone
            save()
            
            //erase the name from the textfield after the save button is clicked
            //so the user gets a blank text fields after hitting the save button
            gameName.text = ""; gameDesc.text = ""
            
            //dimisses the keyboard
            gameName.resignFirstResponder(); gameDesc.resignFirstResponder()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if identifier == "save"
        {
            if gameName.text == ""
            {
                inputWarning.isHidden = false
                return false
            }
        }
        
        return true
    }
    
    //dismiss the keyboard when clicked around the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
}
