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
        XCTAssertEqual(sessionStore.sessionCount(), 0)
        saveSession ()
        XCTAssertEqual(sessionStore.sessionCount(), 1)
    }
    
    func testUpdate () {
        saveSession()
        XCTAssertEqual(sessionStore.sessionCount(), 1)
        var index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        var session = sessionStore.session()
        session.sessionName = "Session 2"
        sessionStore.save()
        saveSession()
        XCTAssertEqual(sessionStore.sessionCount(), 2)
        index = IndexPath.init(row: 1, section: 0)
        sessionStore.selectedRecord = index
        session = sessionStore.session()
        XCTAssertEqual(session.sessionName, "Session 2")
        
    }
    func testDelete () {
        saveSession()
        XCTAssertEqual(sessionStore.sessionCount(), 1)
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        sessionStore.delete()
        XCTAssertEqual(sessionStore.sessionCount(), 0)
    }
    func testAddNotes () {
        saveSession()
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        XCTAssertEqual(sessionStore.notes()?.count, 0)
        let note = sessionStore.newNote()
        note.wineName = "Wine Name"
        sessionStore.addToNotes(note)
        XCTAssertEqual(sessionStore.notes()!.count, 1)
    }
}
