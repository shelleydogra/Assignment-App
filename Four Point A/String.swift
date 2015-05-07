//
//  String.swift
//  Four Point A
//
//  Created by Shelley on 4/18/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

extension String {
    
    var asDate:NSDate! {
        let styler = NSDateFormatter()
        styler.dateFormat = "dd/M/yyyy, H:mm"
        return styler.dateFromString(self)
    
    }
    
    func asDateFormattedWith(format:String) -> NSDate! {
        let styler = NSDateFormatter()
        styler.dateFormat = format
        return styler.dateFromString(self)
    }
    
    

    
}