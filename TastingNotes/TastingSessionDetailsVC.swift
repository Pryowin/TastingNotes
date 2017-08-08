//
//  TastingSessionDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionDetailsVC: UIViewController, UITextFieldDelegate {
    
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
            let updateSession = sessionStore.frc.object(at: sessionStore.selectedRecord)
            updateSession.sessionName = sessionName.text
            updateSession.sessionLocation = sessionLocation.text
        } else {
            let addSession = TastingSession(context: context)
            addSession.sessionDate = dateCreated
            addSession.sessionId = UUID() as NSUUID
            addSession.sessionName = sessionName.text
            addSession.sessionLocation = sessionLocation.text
        }
        
        sessionStore.save()
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sessionName.delegate = self
        self.sessionLocation.delegate = self
        
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
    
    
    func dismissKeyboard () {
        view.endEditing(true)
    }
    
    //MARK: - Delegate Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
