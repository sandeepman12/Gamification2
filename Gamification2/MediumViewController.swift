//
//  MediumViewController.swift
//  Gamification2
//
//  Created by Mostafa Apu on 6/15/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import UIKit
import CoreData

class MediumViewController: UITableViewController
{
    var gameNameArray:[Activity] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MediumViewController.addItem))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    //retrives the data and shows it on the table
    func fetchData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        
        do {
            gameNameArray = try context.fetch(Activity.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    //deletes the users game file from the tableView
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
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
    
    
    func addItem()
    {
        let alertController = UIAlertController(title: "Type your Activities", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField {
                self.saveItem(itemToSave: field.text!)
                self.tableView.reloadData()
            }
        }))
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Type"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: false, completion:nil)
    }
    
    func saveItem(itemToSave: String)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        
        let newActivity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: context)
        
        newActivity.setValue(itemToSave, forKey: "activities")
        
        do {
            try context.save()
            gameNameArray.append(newActivity as! Activity)
        }
        
        catch {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return gameNameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        let name = gameNameArray[indexPath.row]
        cell.textLabel!.text = name.value(forKey: "activities") as? String
        
        return cell
    }
}
