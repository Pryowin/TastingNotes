//
//  TastingNotesDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/9/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingNotesDetailsVC: UITableViewController {
    
    //MARK: - Variables
    
    var sessionStore: TastingSessionStore!
    var editMode: Bool!
    
    let sectionTitles = ["Description", "Appearance", "Nose", "Taste", "Conclusion"]
    var sectionShows = [true,true,true,true,true]
    let rowHeight: CGFloat = 44
    let sectionHeaderColor = "#e29b0d"
    let sectionHeaderTextColor = "#574852"
    let sectionHeaderHeight: CGFloat = 40
    let sectionHeaderTextWidth = 200
    let sectionHeaderSpacing = 8
    let sectionHeaderButtonWidth = 30

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
    func pressed(sender: UIButton!){
        let section = sender.tag
        sectionShows[section] = !sectionShows[section]
        self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        headerView.backgroundColor = UIColor.init(hexColor: sectionHeaderColor)
        
        let sectionHeaderTextHeight = sectionHeaderButtonWidth
        let sectionHeaderButtonHeight = sectionHeaderButtonWidth
        
        let verticalOffset = (Int(sectionHeaderHeight) - sectionHeaderButtonWidth) / 2
        
        let sectionTitle = UILabel()
        sectionTitle.textColor = UIColor.init(hexColor: sectionHeaderTextColor)
        sectionTitle.text = sectionTitles[section]
        sectionTitle.frame = CGRect(x: sectionHeaderSpacing,  y: verticalOffset, width: sectionHeaderTextWidth, height: sectionHeaderTextHeight)
        headerView.addSubview(sectionTitle)
        
        let sectionWidth = Int(self.view.frame.width)
        let buttonX = sectionWidth - sectionHeaderSpacing - sectionHeaderButtonWidth
        
        let collapseButton: UIButton = UIButton(frame: CGRect(x: buttonX, y: verticalOffset, width: sectionHeaderButtonWidth, height: sectionHeaderButtonHeight))

        if sectionShows[section] {
            collapseButton.setImage(#imageLiteral(resourceName: "icons8-Slide Up-50"), for: .normal)
        } else {
            collapseButton.setImage(#imageLiteral(resourceName: "icons8-Down Button-50"), for: .normal)
        }

        collapseButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        collapseButton.isEnabled = true
        collapseButton.isHidden = false
        collapseButton.tag = section
        collapseButton.setTitleColor(UIColor.white, for: .normal)
        headerView.addSubview(collapseButton)
        
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = indexPath.section
        if sectionShows[section] {
            return rowHeight
        } else {
            return 0
        }
    }
    
    // Redraw screen if device has changed orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       
        self.tableView.reloadData()
    }
}

