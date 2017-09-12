//
//  VenueViewController.swift
//  TastingNotes
//
//  Created by David Burke on 9/11/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit

class VenueViewController: UITableViewController {
    
    var venueNames: [String]!
    var session: TastingSessionStore!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return venueNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath)
        
        cell.textLabel?.text = venueNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVenue = venueNames[indexPath.row]
        session.fourSquareLocation = selectedVenue
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: venueSelected, object: nil)
    }
}
