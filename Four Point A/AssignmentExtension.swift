//
//  AssignmentExtension.swift
//  Four Point A
//
//  Created by Shelley on 5/5/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

extension Assignment {
    
    
    
    var daysLeft: Int {
        
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let dayComponents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: NSDate(), toDate: dueDate, options: nil)
        
        let days = dayComponents.day
        
        return days
    }

    
    
}