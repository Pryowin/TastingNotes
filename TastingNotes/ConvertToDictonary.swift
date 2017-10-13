//
//  ConvertToDictonary.swift
//  TastingNotes
//
//  Created by David Burke on 10/2/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation

struct Blend {
    let grape: String
    let percentage: Int16
}

extension TastingSessionStore {
    
    func convertSessionToDictionary () -> [String:Any] {
        
        var sessionDictionary: [String:Any] = [:]
        let session = self.session()
        
        sessionDictionary["sessionName"] = session.sessionName
        sessionDictionary["sessionLocation"] = session.sessionLocation
        sessionDictionary["sessionDate"] = session.sessionDate! as Date
        
        for note in self.notes()! {
            sessionDictionary[String(describing: note.dateCreated)] = convertTastingNoteToDictionary(note)
        }
        
        return sessionDictionary
    }
    
    func convertTastingNoteToDictionary(_ note: TastingNotes) -> [String:Any] {
        
        var noteDict: [String:Any] = [:]
        
        noteDict["wineName"] = note.wineName
        noteDict["vintage"] = note.vintage
        noteDict["type"] = note.type
        noteDict["region"] = note.region
        noteDict["country"] = note.country
        noteDict["type"] = note.type
        noteDict["colour"] = note.colour
        noteDict["price"] = note.price
        noteDict["noseIntensity"] = note.noseIntensity
        noteDict["noseCharacteristics"] = note.noseCharateristics
        noteDict["noseNotes"] = note.noseNotes
        
        noteDict["grapes"] = convertGrapesToArray()
        
        return noteDict
    }
    func convertGrapesToArray() -> [Blend] {
        var grapesInWine = [Blend]()
        for grape in self.grapesForNote() {
            let blend = Blend(grape: grape.grape!, percentage: grape.percentage)
            grapesInWine.append(blend)
        }
        return grapesInWine
    }

}
