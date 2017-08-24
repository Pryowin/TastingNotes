//
//  Constants.swift
//  TastingNotes
//
//  Created by David Burke on 8/18/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation
import UIKit

let sectionTitles = ["Description", "Appearance", "Nose", "Taste", "Conclusion"]

let rowHeight: CGFloat = 44

struct SectionHeader {
    static let color = "#e29b0d"
    static let textColor  = "#574852"
    static let height: CGFloat = 40
    static let textWidth = 200
    static let textHeight = 30
    static let spacing = 8
    static let buttonWidth = 30
    static let buttonHeight = 30
}

let autoCompleteValues = [
    "color": ["Red", "White", "Rosé"],
    "type": ["Still", "Sparkling", "Dessert", "Port"],
    "appearanceColor": ["Amber", "Gold", "Straw", "Pink", "Salmon", "Orange", "Purple", "Ruby", "Garnet", "Tawney"],
    "appearanceClarity": ["Clear", "Hazy"],
    "appearanceIntensity": ["Pale", "Medium", "Deep"],
    "noseIntensity": ["Light", "Medium", "Prounounced"],
    "tasteSweetness": ["Dry", "Off Dry", "Medium", "Sweet"],
    "tasteAcidity": ["Low", "Medium", "Medium Plus", "High" ],
    "tasteTannin": ["Low", "Medium", "High"],
    "tasteBody": ["Light", "Medium", "Full"],
    "tasteFinish": ["Short", "Medium", "Long"]
]
