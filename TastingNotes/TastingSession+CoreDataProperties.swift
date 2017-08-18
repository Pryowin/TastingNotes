//
//  TastingSession+CoreDataProperties.swift
//  TastingNotes
//
//  Created by David Burke on 8/14/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation
import CoreData


extension TastingSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TastingSession> {
        return NSFetchRequest<TastingSession>(entityName: "TastingSession")
    }

    @NSManaged public var sessionDate: NSDate?
    @NSManaged public var sessionId: NSUUID?
    @NSManaged public var sessionLat: Float
    @NSManaged public var sessionLocation: String?
    @NSManaged public var sessionLon: Float
    @NSManaged public var sessionName: String?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension TastingSession {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: TastingNotes)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: TastingNotes)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
