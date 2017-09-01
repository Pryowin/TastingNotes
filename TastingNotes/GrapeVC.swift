//
//  GrapeVC.swift
//  TastingNotes
//
//  Created by David Burke on 9/1/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class GrapeVC: UIViewController,
                UITableViewDelegate,
                UITableViewDataSource {
    
    var grapeStore: GrapeStore!
    
    @IBAction func cancelGrapes(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var grapeTable: UITableView!
    
    override func viewDidLoad() {
        self.grapeTable.dataSource = self
        self.grapeTable.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grapeStore.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrapeCell", for: indexPath)
        let grape = grapeStore.frc.object(at: indexPath)
        cell.textLabel?.text = grape.grape
        
        return cell
    }

}
