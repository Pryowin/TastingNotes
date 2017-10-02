//
//  FourSquareTests.swift
//  TastingNotes
//
//  Created by David Burke on 9/8/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest
import FoursquareAPIClient
@testable import TastingNotes

extension TastingNotesTests {
    
    func testGetVenue() {
        
        let foursquareExpectation = expectation(description: "Foursquare Responded")
        let connection = FourSquareConnection()
        connection.getVenues(lat: 38.344957, long: -122.2837754, limit: 5) { () -> Void in
            XCTAssertFalse(connection.response == nil)
            let venues = connection.returnVenues() 
            XCTAssertGreaterThan(venues.count, 0)
            foursquareExpectation.fulfill()
        }
        waitForExpectations(timeout: 5) {error in
            if let error = error {
                XCTFail("Get Venue failed: \(error)")
            }
        }
    }
}
