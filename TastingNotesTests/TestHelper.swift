//
//  TestHelper.swift
//  TastingNotes
//
//  Created by David Burke on 8/27/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import XCTest
@testable import TastingNotes

extension TastingNotesTests {

    func saveSession() {
        let addSession = sessionStore.sessionToAdd()
        addSession.sessionDate = Date() as NSDate
        addSession.sessionId = UUID() as NSUUID
        addSession.sessionName = "Session"
        addSession.sessionLocation = "Location"
        sessionStore.save()
    }
}
