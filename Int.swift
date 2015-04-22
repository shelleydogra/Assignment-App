//
//  Int.swift
//  Four Point A
//
//  Created by Shelley on 4/21/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

extension Int {
    
    var days: NSTimeInterval {
        let daySec = 60 * 60 * 24
        var daysValue: Double = Double(daySec) * Double(self)
        return daysValue
    }
    
    
    
}