//
//  TastingSessionDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData
import FoursquareAPIClient

class TastingSessionDetailsVC: UIViewController,
                                UITextFieldDelegate,
                                UITableViewDelegate,
                                UITableViewDataSource {

    // MARK: - Variables
    
    var editMode: Bool!
    var sessionStore: TastingSessionStore!
    var grapeStore: GrapeStore!
    var dateFormatter: DateFormatter!
    var dateCreated: NSDate!
    var venues: [String]!
    
    let segueName = "showNoteDetails"
 
    // MARK: - Outlets and Actions
    
    @IBOutlet var sessionName: UITextField!
    @IBOutlet var sessionLocation: UITextField!
    @IBOutlet var addNotes: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if editMode {
            let updateSession = sessionStore.session()
            updateSession.sessionName = sessionName.text
            updateSession.sessionLocation = sessionLocation.text
            sessionStore.save()
            dismiss(animated: true, completion: nil)
        } else {
            let addSession = sessionStore.sessionToAdd()
            addSession.sessionDate = dateCreated
            addSession.sessionId = UUID() as NSUUID
            addSession.sessionName = sessionName.text
            addSession.sessionLocation = sessionLocation.text
            sessionStore.save()
            editMode = true
            addNotes.isEnabled = true
        }
    }
    
    @IBOutlet var activitySpinner: UIActivityIndicatorView!
    
    @IBAction func findLocation(_ sender: Any) {
        let location = Location()
        if location.found {
            activitySpinner.hidesWhenStopped = true
            activitySpinner.isHidden = false
            activitySpinner.startAnimating()
            let connection = FourSquareConnection()
            connection.getVeunues(lat: location.lat, long: location.long, limit: 5) { () -> Void in
                self.activitySpinner.stopAnimating()
                if  connection.gotVenues {
                    self.venues = connection.returnVenues()
                    self.performSegue(withIdentifier: "showVenues", sender: sender)
                } else {
                    print(connection.errorResponse)
                }
            }
        }
        if !location.auth {
            print("User has not authorized location services")
        }
        if location.auth && !location.found {
            print("Unable to find location")
        }
    }
    
    @IBAction func addNotes(_ sender: UIButton) {
        performSegue(withIdentifier: segueName, sender: sender)
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
        tap.cancelsTouchesInView = false
        
        // Setup formatters
        let formatters = Formatters()
        dateFormatter = formatters.dateFormatter
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showVenues), name: venueSelected, object: nil)
        
        // Init fields based on editing mode
        if editMode {
            self.title = "Edit Session Details"
            let session = sessionStore.frc.object(at: sessionStore.selectedRecord)
            sessionName.text = session.sessionName
            sessionLocation.text = session.sessionLocation
            addNotes.isEnabled = true
        } else {
            dateCreated = Date() as NSDate
            self.title = "Add New Session"
            addNotes.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    // MARK: - Functions
    
    func dismissKeyboard () {
        view.endEditing(true)
    }
    
    func showVenues() {
        sessionLocation.text = sessionStore.fourSquareLocation
        if sessionName.text == "" {
            sessionName.text = sessionStore.fourSquareLocation
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        switch segue.identifier {
        case segueName?:
            let sessionNotesController = navController.topViewController as! TastingNotesDetailsVC
            sessionNotesController.sessionStore = sessionStore
            sessionNotesController.grapeStore = grapeStore
            if sender != nil {
                sessionNotesController.editMode = false
            } else {
                sessionNotesController.editMode = true
            }
            case "showVenues"?:
                let venueController =  navController.topViewController as! VenueViewController
                venueController.session = sessionStore
                venueController.venueNames = venues
        default:
            preconditionFailure("Unexpected Segue \(String(describing: segue.identifier))")
        }
    }
    
    // MARK: - Data Source functions
    
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
    
    // MARK: - Delegate Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
