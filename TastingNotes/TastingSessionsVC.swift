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
   
    var fetchedResultsController: NSFetchedResultsController<TastingSession>!
    var dateFormatter: DateFormatter!
    
    
    // MARK: - View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
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
            sessionDetailController.dateString = dateFormatter.string(from: Date())
            sessionDetailController.dateSessionCreated = Date()
            sessionDetailController.fetchedResultsController = fetchedResultsController
        default:
            preconditionFailure("Unexpected Segue \(String(describing: segue.identifier))")
        }
    }
    
    
    // MARK: - Data Source Overrides
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let session = self.fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = session?.sessionName
        let date = session?.sessionDate as Date!
        cell.detailTextLabel?.text = dateFormatter.string(from: date!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController?.managedObjectContext
            let session = self.fetchedResultsController.object(at: indexPath) as NSManagedObject!
            context?.delete(session!)
            do {
                try context?.save()
            } catch let error {
                fatalError("Unable to save \(error)")
            }
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
        default:
            break;
        }
    }
}

