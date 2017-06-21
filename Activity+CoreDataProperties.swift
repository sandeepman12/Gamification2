//
//  Activity+CoreDataProperties.swift
//  Gamification2
//
//  Created by New User on 6/19/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var activities: String?
    @NSManaged public var owner: Game?

}
