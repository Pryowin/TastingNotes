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
        app.launchArguments = ["UI Test"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTastingSessions() {
        
        // Verify correct screen at app start up
        XCTAssert(app.navigationBars["Tasting Sessions"].exists)
        XCTAssert(app.buttons["Add"].exists)
        XCTAssertEqual(rowCount(), 0)
        
    }
    func testAddButtonSegueCorrect () {
        app.buttons["Add"].tap()
        XCTAssert(app.navigationBars["Add New Session"].exists)
        XCTAssert(app.buttons["Cancel"].exists)
        XCTAssert(app.buttons["Save"].exists)
        XCTAssert(app.staticTexts["Session Name:"].exists)
        XCTAssert(app.staticTexts["Location:"].exists)
        XCTAssert(app.textFields["sessionName"].exists)
        XCTAssert(app.textFields["sessionLocation"].exists)
        XCTAssert(app.buttons[addNotesButton].exists)
        XCTAssert((app.buttons[addNotesButton].isEnabled == false))
    }
    func testAddSession () {
        XCTAssertEqual(rowCount(), 0)
        addSession()
        XCTAssert(app.navigationBars["Edit Session Details"].exists)
        app.buttons["Save"].tap()
        XCTAssertEqual(rowCount(), 1)
        XCTAssert(app.tables.element(boundBy: 0).cells.staticTexts["Session"].exists)
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["Session"].tap()
        XCTAssert((app.buttons[addNotesButton].isEnabled == true))
        
    }
    func testDeleteSession () {
        
        addSession()
        app.buttons["Save"].tap()
        
        deleteRow()
        
        XCTAssertEqual(rowCount(), 0)
    }
    
    func testNotesScreen () {
        addSession()
        app.buttons[addNotesButton].tap()
        
        XCTAssert(app.buttons["Cancel"].exists)
        XCTAssert(app.buttons["Save"].exists)
        
        XCTAssert(app.textFields[TextField.wine].exists)
        XCTAssert(app.textFields[TextField.year].exists)
        XCTAssert(app.textFields[TextField.region].exists)
        XCTAssert(app.textFields[TextField.country].exists)
        
        XCTAssert(app.textFields[TextField.Appearance.clarity].exists)
        XCTAssert(app.textFields[TextField.Appearance.color].exists)
        XCTAssert(app.textFields[TextField.Appearance.intensity].exists)
        XCTAssert(app.textFields[TextField.Appearance.notes].exists)
        
        XCTAssert(app.textFields[TextField.Nose.aromas].exists)
        XCTAssert(app.textFields[TextField.Nose.intensity].exists)
        XCTAssert(app.textFields[TextField.Nose.notes].exists)
        
        XCTAssert(app.textFields[TextField.Taste.acidity].exists)
        XCTAssert(app.textFields[TextField.Taste.body].exists)
        XCTAssert(app.textFields[TextField.Taste.finish].exists)
        XCTAssert(app.textFields[TextField.Taste.flavor].exists)
        XCTAssert(app.textFields[TextField.Taste.notes].exists)
        XCTAssert(app.textFields[TextField.Taste.sweetness].exists)
        XCTAssert(app.textFields[TextField.Taste.tannin].exists)
    
        XCTAssert(app.textFields[TextField.Conclusion.summary].exists)
    }
    
    func testAddNote () {
        
        addSession()
        XCTAssertEqual(rowCount(), 0)
    
        addNotes()
        XCTAssertEqual(rowCount(), 1)
        
        XCTAssert(app.tables.element(boundBy: 0).cells.staticTexts[wine].exists)
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts[wine].tap()
       
        XCTAssertEqual(noteField(TextField.wine), wine)
        XCTAssertEqual(noteField(TextField.year), year)
        XCTAssertEqual(noteField(TextField.region), region)
        XCTAssertEqual(noteField(TextField.country), country)
        
        XCTAssertEqual(noteField(TextField.Appearance.color), TextField.Appearance.color)
        XCTAssertEqual(noteField(TextField.Appearance.clarity), TextField.Appearance.clarity)
        XCTAssertEqual(noteField(TextField.Appearance.intensity), TextField.Appearance.intensity)
        XCTAssertEqual(noteField(TextField.Appearance.notes), TextField.Appearance.notes)
        
        XCTAssertEqual(noteField(TextField.Nose.aromas), TextField.Nose.aromas)
        XCTAssertEqual(noteField(TextField.Nose.notes), TextField.Nose.notes)
        XCTAssertEqual(noteField(TextField.Nose.intensity), TextField.Nose.intensity)
        
        XCTAssertEqual(noteField(TextField.Taste.acidity), TextField.Taste.acidity)
        XCTAssertEqual(noteField(TextField.Taste.body), TextField.Taste.body)
        XCTAssertEqual(noteField(TextField.Taste.finish), TextField.Taste.finish)
        XCTAssertEqual(noteField(TextField.Taste.flavor), TextField.Taste.flavor)
        XCTAssertEqual(noteField(TextField.Taste.notes), TextField.Taste.notes)
        XCTAssertEqual(noteField(TextField.Taste.sweetness), TextField.Taste.sweetness)
        XCTAssertEqual(noteField(TextField.Taste.tannin), TextField.Taste.tannin)
        
        XCTAssertEqual(TextField.Conclusion.summary, TextField.Conclusion.summary)
    }
    
    func testDeleteNote () {
        
        addSession()
        addNotes()
        
        deleteRow()
        
        XCTAssertEqual(rowCount(), 0)
    }
    
    func testDeleteAndCancelSessionsWithNotes () {
        addSession()
        addNotes()
        app.buttons["Cancel"].tap()
        let rowsBeforeDelete = rowCount()
        deleteRow()
        XCTAssertEqual(app.alerts.element.label, "Delete")
        app.alerts.element.buttons["Cancel"].tap()
        let rowsAfterDelete = rowCount()
        XCTAssertEqual(rowsBeforeDelete, rowsAfterDelete)
        XCTAssert(!(app.tables.cells.element(boundBy: 0).buttons["Delete"].exists))
    }
    func testDeleteAndConfirmSessionsWithNotes () {
        addSession()
        addNotes()
        app.buttons["Cancel"].tap()
        let rowsBeforeDelete = rowCount()
        deleteRow()
        app.alerts.element.buttons["OK"].tap()
        let expectedRowCount = rowCount() + 1
        XCTAssertEqual(rowsBeforeDelete, expectedRowCount)
        
    }
    func testSectionCollapse () {
        addSession()
        addNotes()
        
    }
}
