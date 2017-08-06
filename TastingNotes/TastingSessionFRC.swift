//
//  FetchedResultsController.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TasingSessionFetchedResultsController: NSObject {
    
    var fetchedResultsController: NSFetchedResultsController<TastingSession>
    
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
        
        let request: NSFetchRequest<TastingSession> = TastingSession.fetchRequest()
        let dateSort = NSSortDescriptor(key: "sessionDate", ascending: false)
        request.sortDescriptors = [dateSort]
        
        let moc = self.persitentContainer.viewContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
        
    }
    
}
