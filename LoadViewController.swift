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
    @IBOutlet weak var tableView: UITableView!
    
    var gameNameArray:[Game] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
