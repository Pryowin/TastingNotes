//
//  TastingSessionDetailsDataDelegate.swift
//  TastingNotes
//
//  Created by David Burke on 9/14/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit

extension TastingSessionDetailsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  editMode {
            return sessionStore.notes()!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! ShowRatingTVC
        let notes = sessionStore.notes()
        let note = notes![indexPath.row]
        cell.wine.text = note.wineName
        
        let score = Double(note.overallRatiing)
        if score == 0 {
            cell.rating.isHidden = true
        } else {
            cell.rating.isHidden = false
            cell.rating.rating = score
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let session = sessionStore.session()
            let notes = sessionStore.notes()
            let note = notes![indexPath.row]
            session.removeFromNotes(note)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sessionStore.selectedNote = indexPath
        performSegue(withIdentifier: segueName, sender: nil)
    }
    
}
