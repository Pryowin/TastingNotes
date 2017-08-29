//
//  GrapeStore.swift
//  TastingNotes
//
//  Created by David Burke on 8/24/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import CoreData

class GrapeStore: NSObject {
    
    var frc: NSFetchedResultsController<TastingNotes>
    
    let persitentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TastingNotes")
        container.loadPersistentStores {(_, error) in
            if let error = error {
                print("Error in setting up Core Data /(error)")
            }
        }
        return container
    } ()
    
    override init() {
        let request: NSFetchRequest<Grapes> = Grapes.fetchRequest()
        let commonSort = NSSortDescriptor(key: "common", ascending: true)
        let nameSort = NSSortDescriptor(key: "grape", ascending: true)
        request.sortDescriptors = [commonSort, nameSort]
        
        var moc: NSManagedObjectContext
        moc = self.persitentContainer.viewContext
       
        frc = NSFetchedResultsController(fetchRequest: request as! NSFetchRequest<TastingNotes>, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
        
        if frc.fetchedObjects?.count == 0 {
            print("Get some records")
        }
        
    }
    
}
