//
//  Formatters.swift
//  TastingNotes
//
//  Created by David Burke on 8/6/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation

class Formatters {
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    } ()
    
    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter ()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en-us")
        return currencyFormatter
    } ()
    
    let backToNumberFormatter: NumberFormatter = {
        let backToNumberFormatter = NumberFormatter ()
        backToNumberFormatter.generatesDecimalNumbers = true
        backToNumberFormatter.numberStyle = NumberFormatter.Style.currency
        return backToNumberFormatter
    }()
    
}
