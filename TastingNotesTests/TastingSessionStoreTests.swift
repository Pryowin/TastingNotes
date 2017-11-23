//
//  TastingSessionStoreTests.swift
//  TastingNotes
//
//  Created by David Burke on 8/27/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest
@testable import TastingNotes

extension TastingNotesTests {
    
    func testAdd () {
        XCTAssertEqual(sessionStore.count(), 0)
        saveSession ()
        XCTAssertEqual(sessionStore.count(), 1)
    }
    
    func testUpdate () {
        saveSession()
        XCTAssertEqual(sessionStore.count(), 1)
        var index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        var session = sessionStore.session()
        session.sessionName = "Session 2"
        sessionStore.save()
        saveSession()
        XCTAssertEqual(sessionStore.count(), 2)
        index = IndexPath.init(row: 1, section: 0)
        sessionStore.selectedRecord = index
        session = sessionStore.session()
        XCTAssertEqual(session.sessionName, "Session 2")
        
    }
    func testDelete () {
        saveSession()
        XCTAssertEqual(sessionStore.count(), 1)
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        sessionStore.delete()
        XCTAssertEqual(sessionStore.count(), 0)
    }
    func testAddNotes () {
        saveSession()
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        XCTAssertEqual(sessionStore.notes()?.count, 0)
        var note = sessionStore.newNote()
        note.wineName = "Wine Name"
        sessionStore.addToNotes(note)
        XCTAssertEqual(sessionStore.notes()!.count, 1)
        note = sessionStore.newNote()
        note.wineName = "Wine Name 2"
        sessionStore.addToNotes(note)
        XCTAssertEqual(sessionStore.notes()!.count, 2)
        note = sessionStore.notes()![0]
        XCTAssertEqual(note.wineName, "Wine Name 2")
        note = sessionStore.notes()![1]
        XCTAssertEqual(note.wineName, "Wine Name")
    }
    func testDeleteNotes () {
        saveSession()
        let firstNoteName = "Wine Name"
        let secondNoteName = "Wine Name 2"
        addNotes(firstNoteName)
        addNotes(secondNoteName)
        let session = sessionStore.session()
        let notes = sessionStore.notes()
        let index = IndexPath.init(row: 0, section: 0)
        let note = notes![index.row]
        session.removeFromNotes(note)
        XCTAssertEqual(sessionStore.notes()!.count, 1)
    }
}
