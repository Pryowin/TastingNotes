//
//  TastingNotesDetailsVC.swift
//  TastingNotes
//
//  Created by David Burke on 8/9/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData
import SearchTextField
import Cosmos

class TastingNotesDetailsVC: UITableViewController {
    
    // MARK: - Variables
    
    var sessionStore: TastingSessionStore!
    var grapeStore: GrapeStore!
    var editMode: Bool!
    var currencyFormatter: NumberFormatter!
    var backToNumberFormatter: NumberFormatter!
    var priceOfWine: Decimal = 0
    
    var sectionShows = [true, true, true, true, true]
    
    // MARK: - Outlets and Actions
    
    @IBOutlet var searchFields: [SearchTextField]!
    
    @IBOutlet var wineName: UITextField!
    @IBOutlet var year: UITextField!
    @IBOutlet var region: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var color: SearchTextField!
    @IBOutlet var type: SearchTextField!
    @IBOutlet var price: UITextField!
    
    @IBAction func priceEditingEnded(_ sender: Any) {
        let num = Decimal.init(string: price.text!) as NSNumber!
        price.text = currencyFormatter.string(from: num!)
        priceOfWine = num as! Decimal
    }
    @IBOutlet var appearanceColour: SearchTextField!
    @IBOutlet var appearanceClarity: SearchTextField!
    @IBOutlet var appearanceIntensity: SearchTextField!
    @IBOutlet var appearanceNotes: UITextField!
  
    @IBOutlet var noseIntensity: SearchTextField!
    @IBOutlet var noseAromas: UITextField!
    @IBOutlet var noseNotes: UITextField!
    
    @IBOutlet var tasteSweetness: SearchTextField!
    @IBOutlet var tasteAcidity: SearchTextField!
    @IBOutlet var tasteTannin: SearchTextField!
    @IBOutlet var tasteBody: SearchTextField!
    @IBOutlet var tasteFlavor: UITextField!
    @IBOutlet var tasteFinish: SearchTextField!
    @IBOutlet var tasteNotes: UITextField!
    
    @IBOutlet var conclusion: UITextField!
    @IBOutlet var rating: CosmosView!
    
    @IBAction func cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if editMode {
            let note = sessionStore.note()
            saveFields(note)
        } else {
            let note = sessionStore.newNote()
            saveFields(note)
            sessionStore.addToNotes(note)
        }
        
        sessionStore.save()
        dismiss(animated: true, completion: nil)
        
    }
    func pressed(sender: UIButton!) {
        let section = sender.tag
        sectionShows[section] = !sectionShows[section]
        self.tableView.reloadData()
    }
    
    // MARK: - Functions
    func saveFields(_ note: TastingNotes) {
        note.wineName = wineName.text
        if let vintage = Int16(year.text!) {
                note.vintage = vintage
        }
        note.region = region.text
        note.country = country.text
        note.colour = color.text
        note.type = type.text
        
        if let number = Decimal.init(string: price.text!) {
            note.price = number as NSDecimalNumber
        } else {
            note.price = priceOfWine as NSDecimalNumber
        }
        
        note.appearanceColour = appearanceColour.text
        note.appearanceClarity = appearanceClarity.text
        note.appearanceIntensity = appearanceIntensity.text
        note.apperanceNotes = appearanceNotes.text
        
        note.noseIntensity = noseIntensity.text
        note.noseCharateristics = noseAromas.text
        note.noseNotes = noseNotes.text
        
        note.tasteSweetness = tasteSweetness.text
        note.tasteBody = tasteBody.text
        note.tasteAcidity = tasteAcidity.text
        note.tasteTannins = tasteTannin.text
        note.tasteNotes = tasteNotes.text
        note.tasteStyle = tasteFlavor.text
        note.tasteFinish = tasteFinish.text
        
        note.conclusion = conclusion.text
        note.overallRatiing = Int16(Int(rating.rating))
    }
    
    // MARK: - View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup formatters
        let formatters = Formatters()
        currencyFormatter = formatters.currencyFormatter
        backToNumberFormatter = formatters.backToNumberFormatter
        
        if editMode {
            let notes = sessionStore.notes()
            let note = notes![sessionStore.selectedNote.row]
            wineName.text = note.wineName
            if note.vintage != 0 {
                year.text = "\(note.vintage)"
            }
            color.text = note.colour
            region.text = note.region
            country.text = note.country
            type.text = note.type
            let priceString = currencyFormatter.string(from: note.price!)
            price.text = priceString
            
            appearanceColour.text = note.appearanceColour
            appearanceClarity.text = note.appearanceClarity
            appearanceIntensity.text = note.appearanceIntensity
            appearanceNotes.text = note.apperanceNotes
            
            noseIntensity.text = note.noseIntensity
            noseAromas.text = note.noseCharateristics
            noseNotes.text = note.noseNotes
            
            tasteFlavor.text = note.tasteStyle
            tasteNotes.text = note.tasteNotes
            tasteTannin.text = note.tasteTannins
            tasteAcidity.text = note.tasteAcidity
            tasteBody.text = note.tasteBody
            tasteFinish.text = note.tasteFinish
            tasteSweetness.text = note.tasteSweetness
            
            conclusion.text = note.conclusion
            rating.rating = Double(note.overallRatiing)
            
        }
        
        for field in searchFields  where field.accessibilityIdentifier != nil {
                configureSearchField(field)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        headerView.backgroundColor = UIColor.init(hexColor: SectionHeader.color)
        
        let verticalOffset = (Int(SectionHeader.height) - SectionHeader.buttonWidth) / 2
        
        let sectionTitle = UILabel()
        sectionTitle.textColor = UIColor.init(hexColor: SectionHeader.textColor)
        sectionTitle.text = sectionTitles[section]
        sectionTitle.frame = CGRect(x: SectionHeader.spacing, y: verticalOffset, width: SectionHeader.textWidth, height: SectionHeader.textHeight)
        headerView.addSubview(sectionTitle)
        
        let sectionWidth = Int(self.view.frame.width)
        let buttonX = sectionWidth - SectionHeader.spacing - SectionHeader.buttonWidth
        
        let collapseButton: UIButton = UIButton(frame: CGRect(x: buttonX, y: verticalOffset, width: SectionHeader.buttonWidth, height: SectionHeader.buttonHeight))

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
        return SectionHeader.height
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        switch segue.identifier {
        case "showGrapes"?:
            let grapeController = navController.topViewController as! GrapeVC
            grapeController.grapeStore = self.grapeStore
            let grapeTableView = GrapeTableView()
            let selectedGrapeTableView = SelectedGrapeTableView()
            grapeTableView.grapeStore = self.grapeStore
            grapeTableView.sessionStore = self.sessionStore
            grapeController.grapeTableView = grapeTableView
            grapeController.selectedGrapeTableView = selectedGrapeTableView
            selectedGrapeTableView.sessionStore = self.sessionStore
            selectedGrapeTableView.grapeStore = self.grapeStore
        default:
             preconditionFailure("Unexpected Segue \(String(describing: segue.identifier))")
        }
    }
    
    // MARK: - Autocomplete functions
    func configureSearchField(_ field: SearchTextField) {
        let fieldName = field.accessibilityIdentifier!
        if autoCompleteValues.keys.contains(fieldName) {
            field.filterStrings(autoCompleteValues[fieldName]!)
            field.theme.bgColor = UIColor.init(hexColor: SectionHeader.color)
            field.theme.fontColor = .black
        } else {
            print("\(#function): Unknown Autocomplete key \(fieldName)")
        }
    }
    
}
