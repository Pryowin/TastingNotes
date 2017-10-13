//
//  SharingTests.swift
//  TastingNotesTests
//
//  Created by David Burke on 10/2/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation

import XCTest
@testable import TastingNotes

extension TastingNotesTests {
    
    func testCreateDictionary() {
        saveSession()
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        let dict = sessionStore.convertSessionToDictionary()
        let sessionName: String = dict["sessionName"] as! String
        XCTAssertEqual(sessionName, "Session")
    }
    func testCreateNoteDictionary() {
        saveSession()
        let firstNoteName = "Wine Name"
        addNotes(firstNoteName)
        let note = sessionStore.note()
        let dict = sessionStore.convertTastingNoteToDictionary(note)
        let vintage: Int16 = dict["vintage"] as! Int16
        XCTAssertEqual(vintage, 1965)
    }
    func testCreateGrapeArray() {
        addGrapes()
        grapeStore.selectedRecord = IndexPath.init(row:0, section: 0)
        saveSession()
        let note = sessionStore.newNote()
        note.wineName = "Wine Name"
        sessionStore.addToNotes(note)
        grapeStore.linkToNote(note, percent: 75)
        grapeStore.selectedRecord = IndexPath.init(row:1, section: 0)
        grapeStore.linkToNote(note, percent: 25)
        let array = sessionStore.convertGrapesToArray()
        XCTAssertEqual(array[1].percentage, 25)
        XCTAssertEqual(array[0].percentage, 75)
        XCTAssertEqual(array[1].grape, "Pinot Noir")
        XCTAssertEqual(array[0].grape, "Barbera")
        grapeStore.selectedRecord = IndexPath.init(row:0, section: 0)
    }
    func testCreateNoteWithGrapes () {
        addGrapes()
        saveSession()
        let note = sessionStore.newNote()
        note.wineName = "Wine Name"
        sessionStore.addToNotes(note)
        grapeStore.linkToNote(note, percent: 75)
        let dict = sessionStore.convertTastingNoteToDictionary(note)
        let grapeInWine = dict["grapes"] as! [Blend]
        XCTAssertEqual(grapeInWine[0].percentage, 75)
        XCTAssertEqual(grapeInWine[0].grape, "Barbera")
    }
    func testCreateSessionWithNotes () {
        saveSession()
        let index = IndexPath.init(row: 0, section: 0)
        sessionStore.selectedRecord = index
        let firstNoteName = "Wine Name"
        addNotes(firstNoteName)
        let dateCreated = String(describing: sessionStore.note().dateCreated)
        let dict = sessionStore.convertSessionToDictionary()
        let note = dict[dateCreated] as! [String:Any]
        let wine = note["wineName"] as! String
        XCTAssertEqual(wine, firstNoteName)
    }
    func testDictSave () {
        addGrapes()
        saveSession()
        let note = sessionStore.newNote()
        note.wineName = "Wine Name"
        sessionStore.addToNotes(note)
        grapeStore.linkToNote(note, percent: 75)
        let dict = sessionStore.convertTastingNoteToDictionary(note)
        let url = dict.exportToFileURL()
        XCTAssertNotNil(url)
    }
        
}
