//
//  GrapeStoreTests.swift
//  TastingNotes
//
//  Created by David Burke on 8/30/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest
@testable import TastingNotes

extension TastingNotesTests {
    
    func testAddGrape() {
        XCTAssertEqual(grapeStore.count(), 0)
        addGrapes()
        XCTAssertEqual(grapeStore.count(), 2)
    }
    
    func testDeleteGrape() {
        addGrapes()
        grapeStore.delete()
        XCTAssertEqual(grapeStore.count(), 1)
    }
    
    func testLoadCSV() {
        grapeStore.importCSV()
        XCTAssertGreaterThan(grapeStore.count(), 100)
    }
    func testFIlterGrapes() {
        grapeStore.importCSV()
        let pinotCount = grapeStore.returnFilteredSet("Pinot").count
        XCTAssertLessThan(pinotCount, 5)
        XCTAssertGreaterThan(pinotCount, 0)
        
    }
    func testLinkToNote() {
        addGrapes()
        grapeStore.selectedRecord = IndexPath.init(row:0, section: 0)
        saveSession()
        let note = sessionStore.newNote()
        note.wineName = "Wine Name"
        sessionStore.addToNotes(note)
        XCTAssertFalse(grapeStore.isLinkedToNote(note))
        grapeStore.linkToNote(note, percent: 10)
        XCTAssert(grapeStore.isLinkedToNote(note))
    }
}
