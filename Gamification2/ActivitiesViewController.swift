//
//  ActivitiesViewController.swift
//  Gamification2
//
//  Created by Mostafa Apu on 6/14/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource
{
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //an array to hold the "Game" ENITTY
    var gameNameArray:[Game] = []
    
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
    
    @IBAction func addButton(_ sender: Any)
    {
        //if the textfields ("gameName") is not empty, this happens
        if field.text != ""
        {
            //reference a variable to an ENTITY in the "Gamification2.xcdatamodeld"
            let newActivity = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context)
            
            //sets the attributes in the "Gamification2.xcdatamodeld" for the "Game" ENTITY
            /*
             attributes: "gameName" & "gameDesc"
             */
            
            newActivity.setValue(self.field!.text, forKey: "activities")
            
            // calls the custom save function to save data to the phone
            save()
        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.fetchData()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return gameNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name = gameNameArray[indexPath.row]
        cell.textLabel!.text = name.activities
        
        return cell
    }
    
    //deletes the users game file from the tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        
        if editingStyle == .delete
        {
            let user = gameNameArray[indexPath.row]
            context.delete(user)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //custom FETCH function call
            fetchData()
        }
        
        tableView.reloadData()
    }
    
    //retrives the data and shows it on the table
    func fetchData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        
        do {
            gameNameArray = try context.fetch(Game.fetchRequest())
        } catch {
            print(error)
        }
    }
}
