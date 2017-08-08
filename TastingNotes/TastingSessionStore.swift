//
//  FetchedResultsController.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TasingSessionStore: NSObject {
    
    var frc: NSFetchedResultsController<TastingSession>
    var selectedRecord: IndexPath
       
    let persitentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TastingNotes")
        container.loadPersistentStores {(description, error) in
            if let error = error {
                print("Error in setting up Core Data /(error)")
            }
        }
        return container
    } ()
    
    override init() {
        
        selectedRecord = IndexPath.init(row:0, section: 0)
        let request: NSFetchRequest<TastingSession> = TastingSession.fetchRequest()
        let dateSort = NSSortDescriptor(key: "sessionDate", ascending: false)
        request.sortDescriptors = [dateSort]
        
        let moc = self.persitentContainer.viewContext
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
        
    }
    
    func save() {
        
        do {
            try self.frc.managedObjectContext.save()
        } catch let error {
            fatalError("Unable to save \(error)")
        }
    }
}