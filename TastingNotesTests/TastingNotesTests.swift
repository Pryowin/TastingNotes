//
//  TastingNotesTests.swift
//  TastingNotesTests
//
//  Created by David Burke on 8/3/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest
@testable import TastingNotes

class TastingNotesTests: XCTestCase {
    
    var sessionStore: TastingSessionStore!
    var grapeStore: GrapeStore!
    
    override func setUp() {
        super.setUp()
        
        let store = TastingNotesManagedObjectContext(testmode: true)
        sessionStore = TastingSessionStore(usingManagedObjectContext: store.moc)
        grapeStore = GrapeStore(usingManagedObjectContext: store.moc)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  }
