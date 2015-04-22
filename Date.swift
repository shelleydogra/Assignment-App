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
    
    var subtractDays: Int {
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let dayComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate(), toDate: NSDate(), options: nil)
        
        let days = dayComponents.day
        
        return days
    }
    
    func tillDate(dueDate date: NSDate) -> Int {
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let dayComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate(), toDate: date, options: nil)
        
        let days = dayComponents.day
        
        return days
    }
    
}


