//
//  Store.swift
//  TastingNotes
//
//  Created by David Burke on 8/28/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import CoreData

class TastingNotesManagedObjectContext: NSObject {
    
    let moc: NSManagedObjectContext
    
    let pesistentManagagedObjectContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "TastingNotes")
        container.loadPersistentStores {(_, error) in
            if let error = error {
                print("Error in setting up Core Data /(error)")
            }
        }
        return container.viewContext
    } ()
    
    let setUpInMemoryManagedObjectContext: NSManagedObjectContext = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    } ()
    
    init(testmode: Bool) {
        
        if testmode {
            moc = setUpInMemoryManagedObjectContext
        } else {
            moc = pesistentManagagedObjectContext
        }
        
    }
    convenience override init() {
        self.init(testmode: false)
    }
}
