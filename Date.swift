//
//  Date.swift
//  Four Point A
//
//  Created by Shelley on 4/16/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

extension NSDate {
    
    var formattedMedium:String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        return formatter.stringFromDate(self)
    }
    
    var formattedLong:String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        return formatter.stringFromDate(self)
    }
    
    var formattedShort:String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        return formatter.stringFromDate(self)
    }

    
}


