//
//  GrapeTableView.swift
//  TastingNotes
//
//  Created by David Burke on 9/1/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class GrapeTableView: NSObject, UITableViewDelegate, UITableViewDataSource,
    UISearchBarDelegate,
    UISearchDisplayDelegate {
    
    var grapeStore: GrapeStore!
    var sessionStore: TastingSessionStore!
    var selectedGrapeTable: UITableView!
    var grapeTable: UITableView!
    var activeViewController: UIViewController!
    
    var filterString: String!
    var searchActive: Bool = false
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return grapeStore.returnFilteredSet(filterString).count
        } else {
            return grapeStore.count()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrapeCell", for: indexPath)
        var grape: Grapes
        if searchActive {
            grape = grapeStore.returnFilteredSet(filterString)[indexPath.row] as! Grapes
        } else {
            grape = grapeStore.frc.object(at: indexPath)
        }
        cell.textLabel?.text = grape.grape
        cell.textLabel?.textColor =  grape.type == "Red" ? UIColor.red : UIColor.white
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        grapeStore.selectedRecord = indexPath
        let note = sessionStore.note()
        var percent: Int16 = 0
       
        if !grapeStore.isLinkedToNote(note) {
            let alertController = UIAlertController(title: "Add Grape", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) -> Void in
                textField.placeholder = "percentage"
                textField.keyboardType = .numberPad
            }
            
            let okAction = UIAlertAction(title: "OK", style: .default) {_ -> Void in
                if let text = alertController.textFields?.first?.text {
                    if let number = Int16(text) {
                        percent = number
                    }
                }
                self.grapeStore.linkToNote(note, percent: percent)
                tableView.reloadData()
                self.selectedGrapeTable.reloadData()
            }
            alertController.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .cancel,
                                             handler: nil)
            alertController.addAction(cancelAction)
            
            activeViewController.present(alertController,
                         animated: true,
                         completion: nil)
        }
    }
    // MARK: 	- Search Bar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.text = ""
        grapeTable.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchActive = searchText.characters.count > 0 ? true : false
        
        filterString = searchText
        grapeTable.reloadData()
    }
}
