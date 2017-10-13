//
//  SaveDictionary.swift
//  TastingNotes
//
//  Created by David Burke on 10/11/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func exportToFileURL() -> URL? {
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let name = "Session"
        let saveFileURL = path.appendingPathComponent("/\(name).tsn")
        (self as NSDictionary).write(to: saveFileURL, atomically: true)
        return saveFileURL
    }
}
