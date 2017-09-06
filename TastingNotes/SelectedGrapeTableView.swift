//
//  SelectedGrapeTableView.swift
//  TastingNotes
//
//  Created by David Burke on 9/1/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreData

class SelectedGrapeTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var sessionStore: TastingSessionStore!
    var grapeStore: GrapeStore!
    var activeViewController: UIViewController!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SectionHeader.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        
        footerView.backgroundColor = UIColor.init(hexColor: SectionHeader.color)
        
        let verticalOffset = (Int(SectionHeader.height) - SectionHeader.buttonWidth) / 2
        
        let sectionTitle = UILabel()
        sectionTitle.textColor = UIColor.init(hexColor: SectionHeader.textColor)
        sectionTitle.text = "Total:"
        sectionTitle.frame = CGRect(x: SectionHeader.spacing, y: verticalOffset, width: SectionHeader.textWidth, height: SectionHeader.textHeight)
        footerView.addSubview(sectionTitle)
        
        let totalValue = UILabel()
        totalValue.textColor = UIColor.init(hexColor: SectionHeader.textColor)
        totalValue.text = String(sessionStore.total())
        totalValue.textAlignment = .right
        let sectionWidth = Int(activeViewController.view.frame.width)
        let totalX = sectionWidth - SectionHeader.spacing - SectionHeader.textWidth
        totalValue.frame = CGRect(x: totalX, y: verticalOffset, width: SectionHeader.textWidth, height: SectionHeader.textHeight)
        footerView.addSubview(totalValue)
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionStore.selectedGrapes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedGrapeCell", for: indexPath)
        let grape = sessionStore.grapesForNote()[indexPath.row]
        cell.textLabel?.text = grape.grape
        cell.detailTextLabel?.text = String(grape.percentage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let note = sessionStore.note()
            let grape = sessionStore.grapesForNote()[indexPath.row]
            note.removeFromHasInIt(grape)
            sessionStore.save()
            grapeStore.save()
            tableView.reloadData()
        }
    }
}
