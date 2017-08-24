//
//  Grapes+CoreDataProperties.swift
//  TastingNotes
//
//  Created by David Burke on 8/14/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation
import CoreData

extension Grapes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grapes> {
        return NSFetchRequest<Grapes>(entityName: "Grapes")
    }

    @NSManaged public var grape: String?
    @NSManaged public var type: String?
    @NSManaged public var common: Int16
    @NSManaged public var percentages: NSSet?

}

// MARK: Generated accessors for percentages
extension Grapes {

    @objc(addPercentagesObject:)
    @NSManaged public func addToPercentages(_ value: Percentages)

    @objc(removePercentagesObject:)
    @NSManaged public func removeFromPercentages(_ value: Percentages)

    @objc(addPercentages:)
    @NSManaged public func addToPercentages(_ values: NSSet)

    @objc(removePercentages:)
    @NSManaged public func removeFromPercentages(_ values: NSSet)

}
