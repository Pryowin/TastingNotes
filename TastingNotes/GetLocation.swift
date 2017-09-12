//
//  GetLocation.swift
//  TastingNotes
//
//  Created by David Burke on 9/12/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import CoreLocation

struct Location {
    var lat: Double = 0
    var long: Double = 0
    var auth: Bool = false
    var found: Bool = false
    
    init() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == CLAuthorizationStatus.authorizedWhenInUse {
            auth = true
            let location = locationManager.location
            if location?.coordinate.latitude != nil {
                found = true
                lat = (location?.coordinate.latitude)!
                long = (location?.coordinate.longitude)!
            }
        }
        
    }
}
