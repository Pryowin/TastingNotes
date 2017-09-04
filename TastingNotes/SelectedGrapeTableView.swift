//
//  SelectedGrapeTableView.swift
//  TastingNotes
//
//  Created by David Burke on 9/1/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class SelectedGrapeTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var sessionStore: TastingSessionStore!
    var grapeStore: GrapeStore!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionStore.selectedGrapes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedGrapeCell", for: indexPath)
        let grape = sessionStore.grapesForNote()[indexPath.row]
        cell.textLabel?.text = grape.grape
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let note = sessionStore.note()
            let percentages = Array(note.hasInIt!)
            let percentage = percentages[indexPath.row] as! Percentages
            note.removeFromHasInIt(percentage)
            sessionStore.save()
            grapeStore.save()
            tableView.reloadData()
        }
    }
}
