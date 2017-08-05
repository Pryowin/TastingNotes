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
    
    // MARK: - Outlets and Actions
    
    @IBAction func addSesison(_ sender: UIBarButtonItem) {
        let context = fetchedResultsController.managedObjectContext
        let session = TastingSession(context: context)
        
        session.sessionDate = Date() as NSDate
        let randomSession = arc4random() % 9
        session.sessionName = "Session \(randomSession)"
        do {
            try context.save()
        } catch let error {
            fatalError("Unable to save \(error)")
        }
        
    }
    
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
        fetchedResultsController.delegate = self
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initFetchedResultsController()
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
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
        let session = self.fetchedResultsController?.object(at: indexPath)
        cell.textLabel?.text = session?.sessionName
        let date = session?.sessionDate as Date!
        cell.detailTextLabel?.text = dateFormatter.string(from: date!)

        return cell

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController?.managedObjectContext
            let session = self.fetchedResultsController.object(at: indexPath) as NSManagedObject!
            context?.delete(session!)
            do {
                try context?.save()
            } catch let error {
                fatalError("Unable to save \(error)")
            }
           
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break;
        }
    }

}

