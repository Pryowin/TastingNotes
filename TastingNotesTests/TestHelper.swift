//
//  TestHelper.swift
//  TastingNotes
//
//  Created by David Burke on 8/27/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest
@testable import TastingNotes

extension TastingNotesTests {

    func saveSession() {
        let addSession = sessionStore.sessionToAdd()
        addSession.sessionDate = Date() as NSDate
        addSession.sessionId = UUID() as NSUUID
        addSession.sessionName = "Session"
        addSession.sessionLocation = "Location"
        sessionStore.save()
    }
    
    func addNotes (_ wineName: String) {
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        let note = sessionStore.newNote()
        note.wineName = wineName
        note.vintage = 1965
        sessionStore.addToNotes(note)
    }
    
    func addGrapes() {
        var addGrapes = grapeStore.grapeToAdd()
        addGrapes.grape = "Pinot Noir"
        addGrapes.type = "Red"
        addGrapes.common = 1
        addGrapes = grapeStore.grapeToAdd()
        addGrapes.grape = "Barbera"
        addGrapes.type = "Red"
        addGrapes.common = 1
        grapeStore.save()
    }
}
