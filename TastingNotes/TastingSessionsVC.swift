//
//  ViewController.swift
//  TastingNotes
//
//  Created by David Burke on 8/3/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionsVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Variables
   
    var sessionStore: TasingSessionStore!
    var dateFormatter: DateFormatter!

    // MARK: - View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let formatters = Formatters()
        dateFormatter = formatters.dateFormatter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        switch segue.identifier{
        case "showSessionDetails"?:
            let sessionDetailController = navController.topViewController as! TastingSessionDetailsVC
            sessionDetailController.sessionStore = sessionStore
            if (sender != nil) {
                sessionDetailController.editMode = false
            } else {
                sessionDetailController.editMode = true
            }
        default:
            preconditionFailure("Unexpected Segue \(String(describing: segue.identifier))")
        }
    }
    
    
    // MARK: - Data Source Overrides
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sessionStore.frc.fetchedObjects!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let session = sessionStore.frc.object(at: indexPath)
        cell.textLabel?.text = session.sessionName
        let date = session.sessionDate as Date!
        cell.detailTextLabel?.text = dateFormatter.string(from: date!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sessionStore.selectedRecord = indexPath
        performSegue(withIdentifier: "showSessionDetails", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sessionStore.delete(recordToDelete: indexPath)
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break;
        }
    }
}

