//
//  UIColorExtension.swift
//  TastingNotes
//
//  Created by David Burke on 8/12/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexColor: String) {
        
        let charSet = CharacterSet.whitespacesAndNewlines
        let hexString = hexColor.trimmingCharacters(in: charSet)
        
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
        
    }
}
