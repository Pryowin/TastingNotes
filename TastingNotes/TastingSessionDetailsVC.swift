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
    
    var editMode: Bool!
    var sessionStore: TasingSessionStore!
    var dateFormatter: DateFormatter!
    var dateCreated: NSDate!
    
    // MARK: - Outlets and Actions
    
    @IBOutlet var sessionName: UITextField!
    @IBOutlet var sessionLocation: UITextField!
    @IBOutlet var sessionDate: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func save(_ sender: UIBarButtonItem) {
        let context = sessionStore.frc.managedObjectContext
        
        if editMode {
            let session = sessionStore.frc.object(at: sessionStore.selectedRecord)
            session.sessionName = sessionName.text
            session.sessionLocation = sessionLocation.text
        } else {
            let session = TastingSession(context: context)
            session.sessionDate = dateCreated
            session.sessionName = sessionName.text
            session.sessionLocation = sessionLocation.text
        }
        
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
        
        let formatters = Formatters()
        dateFormatter = formatters.dateFormatter
        
        if editMode {
            self.title = "Edit Session Details"
            let session = sessionStore.frc.object(at: sessionStore.selectedRecord)
            sessionName.text = session.sessionName
            sessionLocation.text = session.sessionLocation
            sessionDate.text = dateFormatter.string(from: session.sessionDate! as Date)
        } else {
            sessionDate.text = dateFormatter.string(from: Date())
            dateCreated = Date() as NSDate
            self.title = "Add New Session"
        }
    }
    
}
