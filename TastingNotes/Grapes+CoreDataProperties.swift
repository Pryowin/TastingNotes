//
//  Grapes+CoreDataProperties.swift
//  TastingNotes
//
//  Created by David Burke on 9/4/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation
import CoreData

extension Grapes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grapes> {
        return NSFetchRequest<Grapes>(entityName: "Grapes")
    }

    @NSManaged public var common: Int16
    @NSManaged public var grape: String?
    @NSManaged public var type: String?
    @NSManaged public var isPresentAt: NSSet?

}

// MARK: Generated accessors for isPresentAt
extension Grapes {

    @objc(addIsPresentAtObject:)
    @NSManaged public func addToIsPresentAt(_ value: Percentages)

    @objc(removeIsPresentAtObject:)
    @NSManaged public func removeFromIsPresentAt(_ value: Percentages)

    @objc(addIsPresentAt:)
    @NSManaged public func addToIsPresentAt(_ values: NSSet)

    @objc(removeIsPresentAt:)
    @NSManaged public func removeFromIsPresentAt(_ values: NSSet)

}
