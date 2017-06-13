//
//  LoadViewController.swift
//  Gamification2
//
//  Created by Mostafa Apu on 6/12/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import UIKit
import CoreData

class LoadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //refernce to the tableView in the "Main.storyboard"
    @IBOutlet weak var tableView: UITableView!
    
    //an array to hold the "Game" ENITTY
    var gameNameArray:[Game] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //sets this class for the tableView Scene when clicked on "Load"
        tableView.delegate = self
        tableView.dataSource = self
        
        self.fetchData()
        self.tableView.reloadData()
    }
    
    //# of sections
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    //# of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return gameNameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //this is to add the scores depending on how many items are there
//        for i in 1...gameNameArray.count
//        {
//            let score = i * 10
//            self.scoreLabel.text = "Score: \(score)"
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name = gameNameArray[indexPath.row]
        cell.textLabel!.text = name.gameName
        
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
