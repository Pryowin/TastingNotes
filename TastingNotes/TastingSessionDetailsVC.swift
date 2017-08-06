//
//  TastingSessionDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionDetailsVC: UIViewController {
    
    // MARK: - Variables
    
    var dateString: String!
    var name: String!
    var location: String!
    var dateSessionCreated: Date!
    
    var fetchedResultsController: NSFetchedResultsController<TastingSession>!
    
    // MARK: - Outlets and Actions
    
    @IBOutlet var sessionName: UITextField!
    @IBOutlet var sessionLocation: UITextField!
    @IBOutlet var sessionDate: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func save(_ sender: UIBarButtonItem) {
        let context = fetchedResultsController.managedObjectContext
        let session = TastingSession(context: context)
        
        session.sessionDate = dateSessionCreated as NSDate
        session.sessionName = sessionName.text
        session.sessionLocation = sessionLocation.text
        do {
            try context.save()
        } catch let error {
            fatalError("Unable to save \(error)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: Dismiss keyboard on click outside
    
    // MARK: - View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionName.text = name
        sessionLocation.text = location
        sessionDate.text = dateString
    }
    
}
