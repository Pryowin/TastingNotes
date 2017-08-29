//
//  FetchedResultsController.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionStore: NSObject {
    
    var frc: NSFetchedResultsController<TastingSession>
    var selectedRecord: IndexPath
    var selectedNote: IndexPath
       
    let persitentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TastingNotes")
        container.loadPersistentStores {(_, error) in
            if let error = error {
                print("Error in setting up Core Data /(error)")
            }
        }
        return container
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
        
        selectedRecord = IndexPath.init(row:0, section: 0)
        selectedNote = IndexPath.init(row: 0, section: 0)
        
        let request: NSFetchRequest<TastingSession> = TastingSession.fetchRequest()
        let dateSort = NSSortDescriptor(key: "sessionDate", ascending: false)
        request.sortDescriptors = [dateSort]
        
        var moc: NSManagedObjectContext
        if testmode {
            moc = setUpInMemoryManagedObjectContext
        } else {
            moc = self.persitentContainer.viewContext
        }
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
        
    }
    convenience override init() {
        self.init(testmode: false)
    }
    
    func sessionCount () -> Int {

        return self.frc.fetchedObjects!.count
    }
    
    func session () -> TastingSession {
        return self.frc.object(at: self.selectedRecord)
    }
    
    func sessionToAdd () -> TastingSession {
        return TastingSession(context: self.frc.managedObjectContext)
    }
    
    func newNote () -> TastingNotes {
        return TastingNotes(context: self.frc.managedObjectContext)
    }
    
    func addToNotes (_ note: TastingNotes) {
        self.frc.object(at: self.selectedRecord).addToNotes(note)
    }
    
    func notes() -> [TastingNotes]? {
        
            return (self.frc.object(at: selectedRecord).notes!.allObjects as! [TastingNotes])
    }
    
    func note() -> TastingNotes {
        return self.notes()![self.selectedNote.row]
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
        let session = self.frc.object(at: self.selectedRecord) as NSManagedObject!
        context.delete(session!)
        self.save()
    }
}
