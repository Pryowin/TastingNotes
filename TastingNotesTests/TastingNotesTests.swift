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
    
    override func setUp() {
        super.setUp()
        
        sessionStore = TastingSessionStore(testmode: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  }
