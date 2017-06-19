//
//  Game+CoreDataProperties.swift
//  Gamification2
//
//  Created by New User on 6/19/17.
//  Copyright © 2017 PENN STATE ABINGTON. All rights reserved.
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var gameDesc: String?
    @NSManaged public var gameName: String?
    @NSManaged public var activities: NSSet

}

// MARK: Generated accessors for activities
extension Game {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}
