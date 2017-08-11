//
//  TastingNotesDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/9/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingNotesDetailsVC: UIViewController, UITextViewDelegate {
    
    //MARK: - Variables
    
    var sessionStore: TasingSessionStore!
    var editMode: Bool!
    
    //MARK: - Outlets and Actions
    
    @IBOutlet var wineName: UITextField!
    @IBOutlet var year: UITextField!
    
    
    @IBOutlet var appearanceColour: UITextField!
    @IBOutlet var appearanceClarity: UITextField!
    @IBOutlet var appearanceIntensity: UITextField!
    @IBOutlet var appearanceNotes: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if editMode {
            let notes = sessionStore.notes()
            let note = notes![sessionStore.selectedNote.row]
            note.wineName = wineName.text
            note.vintage = Int16(year.text!)!
            note.appearanceColour = appearanceColour.text
            note.appearanceClarity = appearanceClarity.text
            note.appearanceIntensity = appearanceIntensity.text
            note.apperanceNotes = appearanceNotes.text
        } else {
            let note = TastingNotes(context: sessionStore.frc.managedObjectContext)
            note.wineName = wineName.text
            note.vintage = Int16(year.text!)!
            note.appearanceColour = appearanceColour.text
            note.appearanceClarity = appearanceClarity.text
            note.appearanceIntensity = appearanceIntensity.text
            note.apperanceNotes = appearanceNotes.text
            sessionStore.frc.object(at: sessionStore.selectedRecord).addToNotes(note)
        }
        
        sessionStore.save()
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editMode {
            let notes = sessionStore.notes()
            let note = notes![sessionStore.selectedNote.row]
            wineName.text = note.wineName
            year.text = "\(note.vintage)"
            appearanceColour.text = note.appearanceColour
            appearanceClarity.text = note.appearanceClarity
            appearanceIntensity.text = note.appearanceIntensity
            appearanceNotes.text = note.apperanceNotes
        }
        
    }
}

