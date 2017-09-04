//
//  FetchedResultsController.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionStore: NSObject, Store {
    
    var frc: NSFetchedResultsController<TastingSession>
    var selectedRecord: IndexPath
    var selectedNote: IndexPath
    
    init(usingManagedObjectContext moc: NSManagedObjectContext) {
            
        selectedNote = IndexPath.init(row: 0, section: 0)
        selectedRecord = IndexPath.init(row:0, section: 0)
        
        let request: NSFetchRequest<TastingSession> = TastingSession.fetchRequest()
        let dateSort = NSSortDescriptor(key: "sessionDate", ascending: false)
        request.sortDescriptors = [dateSort]
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
        
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
    
    func selectedGrapes() -> [Percentages] {
        return self.note().hasInIt?.allObjects as! [Percentages]
    }
    func grapesForNote() -> [Percentages] {
        return  self.note().hasInIt?.allObjects as! [Percentages]
    }
    
    func recordToDelete() -> NSManagedObject! {
        return self.frc.object(at: self.selectedRecord) as NSManagedObject!
    }
}
