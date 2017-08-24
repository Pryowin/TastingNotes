//
//  FetchedResultsControllerDelegate.swift
//  TastingNotes
//
//  Created by David Burke on 8/8/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsControllerDelegate {
    var tableView: UITableView!
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}
