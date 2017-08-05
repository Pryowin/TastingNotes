//
//  TastingSession+CoreDataProperties.swift
//  TastingNotes
//
//  Created by David Burke on 8/4/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation
import CoreData


extension TastingSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TastingSession> {
        return NSFetchRequest<TastingSession>(entityName: "TastingSession")
    }

    @NSManaged public var sessionId: NSUUID?
    @NSManaged public var sessionDate: NSDate?
    @NSManaged public var sessionName: String?
    @NSManaged public var sessionLocation: String?
    @NSManaged public var sessionLat: Float
    @NSManaged public var sessionLon: Float

}
