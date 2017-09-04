//
//  GrapeStore.swift
//  TastingNotes
//
//  Created by David Burke on 8/24/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import CoreData
import CSV
import Foundation

class GrapeStore: NSObject, Store {
    
    var frc: NSFetchedResultsController<Grapes>
    var selectedRecord: IndexPath
    let mananagedObjectContext: NSManagedObjectContext!
    
    init(usingManagedObjectContext moc: NSManagedObjectContext) {
        
        selectedRecord = IndexPath.init(row:0, section: 0)
        mananagedObjectContext = moc
        
        let request: NSFetchRequest<Grapes> = Grapes.fetchRequest()
        let commonSort = NSSortDescriptor(key: "common", ascending: false)
        let nameSort = NSSortDescriptor(key: "grape", ascending: true)
        request.sortDescriptors = [commonSort, nameSort]
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
    }
    func grapeToAdd () -> Grapes {
        return Grapes(context: self.frc.managedObjectContext)
    }
    
    func recordToDelete() -> NSManagedObject! {
        return self.frc.object(at: self.selectedRecord) as NSManagedObject!
    }
    
    func isLinkedToNote(_ note: TastingNotes) -> Bool {
        var isLinked: Bool = false
        let grape = self.frc.object(at: self.selectedRecord)
        for pc in note.hasInIt! {
            let percent = pc as! Percentages
            if percent.grapes == grape {
                isLinked = true
            }
        }
        return isLinked
    }
    
    func linkToNote(_ note: TastingNotes) {
        let grape = self.frc.object(at: self.selectedRecord)
        let percentage = Percentages.init(entity: NSEntityDescription.entity(forEntityName: "Percentages", in: mananagedObjectContext)!, insertInto: mananagedObjectContext)
        percentage.percentage = 0
        percentage.grape = grape.grape
        grape.addToIsPresentAt(percentage)
        note.addToHasInIt(percentage)
        self.save()
    }
    
    func importCSV () {
        let file = "Grapes"
        let fileExtension = "csv"
        if let path = Bundle.main.path(forResource: file, ofType: fileExtension) {
            if let stream = InputStream(fileAtPath: path) {
                processLines(stream)
            }
        }
    }
    
    private func processLines(_ stream: InputStream) {
        do {
            let csv = try CSVReader(stream: stream, hasHeaderRow: true)
            while csv.next() != nil {
                let grape = grapeToAdd()
                grape.grape = String(csv["Grape"]!)
                grape.type = String(csv["Type"]!)
                if (String(csv["Common"]!)?.isEmpty)! {
                    grape.common = 0
                } else {
                    grape.common = 1
                }
                self.save()
            }
        } catch {
                print("Unable to read CSV file: \(error) ")
        }
    }
}
