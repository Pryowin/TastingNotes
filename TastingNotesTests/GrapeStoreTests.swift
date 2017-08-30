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
        XCTAssertEqual(grapeStore.count(), 1)
    }
    
    func testDeleteGrape() {
        addGrapes()
        grapeStore.delete()
        XCTAssertEqual(grapeStore.count(), 0)
    }
    
    func testLoadCSV() {
        grapeStore.importCSV()
        XCTAssertGreaterThan(grapeStore.count(), 100)
    }
}
