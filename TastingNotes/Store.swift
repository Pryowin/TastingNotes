//
//  Store.swift
//  TastingNotes
//
//  Created by David Burke on 8/29/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import CoreData

protocol Store {
    
    associatedtype FRR: NSFetchRequestResult
    
    var frc: NSFetchedResultsController<FRR> {get set}
    var selectedRecord: IndexPath {get set}
    
    func recordToDelete() -> NSManagedObject!
    func count() -> Int
    func save()
    func delete()
}

extension Store {
    
    func count() -> Int {
        return self.frc.fetchedObjects!.count
    }
    
    func save() {
        
        do {
            try self.frc.managedObjectContext.save()
            try frc.performFetch()
        } catch let error {
            fatalError("Unable to save \(error)")
        }
    }
    
    func delete() {
        let context = self.frc.managedObjectContext
        let session = recordToDelete()
        context.delete(session!)
        self.save()
    }
}
