//
//  TastingNotesUITests.swift
//  TastingNotesUITests
//
//  Created by David Burke on 8/3/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest

class TastingNotesUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTastingSessions() {
        
        // Verify correct screen at app start up
        XCTAssert(app.staticTexts["Tasting Sessions"].exists)
        XCTAssert(app.buttons["Add"].exists)
        
    }
    func testAddButtonSegueCorrect () {
        app.buttons["Add"].tap()
        XCTAssert(app.staticTexts["Add New Session"].exists)
        XCTAssert(app.buttons["Cancel"].exists)
        XCTAssert(app.buttons["Save"].exists)
        XCTAssert(app.staticTexts["Session Name:"].exists)
        XCTAssert(app.staticTexts["Location:"].exists)
        XCTAssert(app.textFields["sessionName"].exists)
        XCTAssert(app.textFields["sessionLocation"].exists)
        XCTAssert(app.buttons["Add Notes"].exists)
        XCTAssert((app.buttons["Add Notes"].isEnabled == false))
    }
    
}
