//
//  TestConstants.swift
//  TastingNotes
//
//  Created by David Burke on 8/22/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation

let wine = "Wine"
let year = "1965"
let region = "Napa"
let country = "USA"

let addNotesButton = "Add Notes"

struct TextField {
    static let wine = "descriptionName"
    static let year = "descriptionYear"
    static let region = "descriptionRegion"
    static let country = "descriptionCountry"
    
    struct Appearance {
        static let color = "appearanceColor"
        static let intensity = "appearanceIntensity"
        static let clarity = "appearanceClarity"
        static let notes = "appearanceNotes"
    }
    
    struct Nose {
        static let intensity = "noseIntensity"
        static let aromas = "noseAromas"
        static let notes = "noseNotes"
    }
    
    struct Taste {
        static let sweetness = "tasteSweetness"
        static let acidity = "tasteAcidity"
        static let tannin = "tasteTannin"
        static let body = "tasteBody"
        static let flavor = "tasteFlavor"
        static let finish = "tasteFinish"
        static let notes = "tasteNotes"
    }
    
    struct Conclusion {
        static let summary = "summary"
        static let rating = "rating"
    }
}
