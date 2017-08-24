//
//  UITestHelper.swift
//  TastingNotes
//
//  Created by David Burke on 8/21/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest

extension TastingNotesUITests {
    
    func addSession () {
        app.buttons["Add"].tap()
        enterText(field: "sessionName", text: "Session")
        app.buttons["Save"].tap()
    }
    
    func enterText (field: String, text: String) {
        app.textFields[field].tap()
        app.textFields[field].typeText(text)
    }
    
    func rowCount() -> UInt {
        return app.tables.cells.count
    }
    
    func deleteRow() {
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
    }
    
    func addNotes() {
        app.buttons["Add Notes"].tap()
        enterText(field: TextField.year, text: year)
        enterText(field: TextField.wine, text: wine)
        enterText(field: TextField.region, text: region)
        enterText(field: TextField.country, text: country)
        
        enterText(field: TextField.Appearance.color, text: TextField.Appearance.color)
        enterText(field: TextField.Appearance.clarity, text: TextField.Appearance.clarity)
        enterText(field: TextField.Appearance.intensity, text: TextField.Appearance.intensity)
        enterText(field: TextField.Appearance.notes, text: TextField.Appearance.notes)
        
        enterText(field: TextField.Nose.aromas, text: TextField.Nose.aromas)
        enterText(field: TextField.Nose.intensity, text: TextField.Nose.intensity)
        enterText(field: TextField.Nose.notes, text: TextField.Nose.notes)
        
        enterText(field: TextField.Taste.acidity, text: TextField.Taste.acidity)
        enterText(field: TextField.Taste.body, text: TextField.Taste.body)
        enterText(field: TextField.Taste.finish, text: TextField.Taste.finish)
        enterText(field: TextField.Taste.flavor, text: TextField.Taste.flavor)
        enterText(field: TextField.Taste.notes, text: TextField.Taste.notes)
        enterText(field: TextField.Taste.sweetness, text: TextField.Taste.sweetness)
        enterText(field: TextField.Taste.tannin, text: TextField.Taste.tannin)
        
        enterText(field: TextField.Conclusion.summary, text: TextField.Conclusion.summary)
        
        app.buttons["Save"].tap()
    }
    func noteField(_ field: String) -> String {
        return app.textFields[field].value as! String
    }

}
