//
//  FourSquare.swift
//  TastingNotes
//
//  Created by David Burke on 9/8/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit
import FoursquareAPIClient

class FourSquareConnection: NSObject {
    
    var client: FoursquareAPIClient!
    let path = "venues/search"
    var response: Data!
    var gotVenues: Bool!
    var errorResponse: String!
    
    override init() {
        super.init()
        
        var resourceFileDict: NSDictionary?
        if let plistPath = Bundle.main.path(forResource: "configuration", ofType: "plist") {
            resourceFileDict = NSDictionary(contentsOfFile: plistPath)
            if let config = resourceFileDict {
                let fourSquareParams = config.object(forKey: "FoursquareAPI") as! NSDictionary
                let clientID = fourSquareParams.object(forKey: "ClientID") as! String
                let clientSecret = fourSquareParams.object(forKey: "ClientSecret") as! String
                client = FoursquareAPIClient(clientId: clientID, clientSecret: clientSecret)
            }
        }
    }
    
    func getVeunues(lat: Double, long: Double, limit: Int, callback: @escaping () -> Void) {
        
        let parameter: [String: String] = [
            "ll": "\(lat),\(long)",
            "limit": "\(limit)"
        ]
        
        client.request(path: path, parameter: parameter) {result in
            switch result {
            case let .success(data):
                self.gotVenues = true
                self.response = data
                callback()
            case let .failure(error):
                self.gotVenues = false
                self.errorResponse = error.localizedDescription
                callback()
            }
    
        }
    }
    func returnVenues() -> [String] {
        
        var venueNames = [String]()
        do {
            if let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String: Any],
                let resp = json["response"] as? [String: Any],
                let venues = resp["venues"] as?[[String: Any]] {
                for venue in venues {
                    if let venueName = venue["name"] as? String {
                        venueNames.append(venueName)
                    }
                }
            }
        } catch {
            print("JSON Error")
        }
        return venueNames
    }
    
}
        
