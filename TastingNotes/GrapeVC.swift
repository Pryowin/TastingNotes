//
//  GrapeVC.swift
//  TastingNotes
//
//  Created by David Burke on 9/1/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class GrapeVC: UIViewController {
    
    var grapeStore: GrapeStore!
    var grapeTableView: GrapeTableView!
    var selectedGrapeTableView: SelectedGrapeTableView!
    
    @IBAction func cancelGrapes(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var grapeTable: UITableView!
    
    @IBOutlet var selectedGrapesTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        grapeTable.delegate = grapeTableView
        grapeTable.dataSource = grapeTableView
        selectedGrapesTable.delegate = selectedGrapeTableView
        selectedGrapesTable.dataSource = selectedGrapeTableView
        grapeTableView.selectedGrapeTable = selectedGrapesTable
    }
}
