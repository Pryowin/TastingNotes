//
//  TastingSessionDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionDetailsVC: UIViewController,
                                UITextFieldDelegate,
                                UITableViewDelegate,
                                UITableViewDataSource{

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
    
    @IBAction func addNotes(_ sender: UIButton) {
        
        let note = TastingNotes(context: sessionStore.frc.managedObjectContext)
        note.wineName = "Pinot Noir"
        sessionStore.frc.object(at: sessionStore.selectedRecord).addToNotes(note)
        sessionStore.save()
        tableView.reloadData()
    }
   
    @IBOutlet var tableView: UITableView!
   
     // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup text fields so that Return will dismiss keyboatd
        self.sessionName.delegate = self
        self.sessionLocation.delegate = self
        
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Setup formatters
        let formatters = Formatters()
        dateFormatter = formatters.dateFormatter
        
        tableView.delegate = self
        tableView.dataSource = self
        sessionStore.frc.delegate = nil
        
        
        // Init fields based on editing mode
        if editMode {
            self.title = "Edit Session Details"
            let session = sessionStore.frc.object(at: sessionStore.selectedRecord)
            sessionName.text = session.sessionName
            sessionLocation.text = session.sessionLocation
        } else {
            dateCreated = Date() as NSDate
            self.title = "Add New Session"
        }
    }
    
    func dismissKeyboard () {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // TODO: Move notes to Session Store
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (sessionStore.notes().count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let notes = sessionStore.notes()
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.wineName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let session = sessionStore.frc.object(at: sessionStore.selectedRecord)
            let notes = sessionStore.notes()
            let note = notes[indexPath.row]
            session.removeFromNotes(note)
            tableView.reloadData()
        }
    }
    
    //MARK: - Delegate Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
     
}
