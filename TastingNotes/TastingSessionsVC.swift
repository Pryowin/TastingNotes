//
//  ViewController.swift
//  TastingNotes
//
//  Created by David Burke on 8/3/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class TastingSessionsVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Variables
    
    var fetchedResultsController: NSFetchedResultsController<TastingSession>!
    
    let persitentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TastingNotes")
        container.loadPersistentStores {(description, error) in
            if let error = error {
                print("Error in setting up Core Data /(error)")
            }
        }
        return container
    } ()
    
    
    // MARK: - Functions
    
    func initFetchedResultsController() {
        
        let request: NSFetchRequest<TastingSession> = TastingSession.fetchRequest()
        let dateSort = NSSortDescriptor(key: "sessionDate", ascending: false)
        request.sortDescriptors = [dateSort]
        
        let moc = self.persitentContainer.viewContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to init FetchedResultsController: \(error)")
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initFetchedResultsController()
    }
    
    // MARK: - View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Data Source Overrides
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let record = self.fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = record?.sessionName
        return cell
    
        
    }


}

