//
//  CourseExtension.swift
//  Four Point A
//
//  Created by Shelley on 5/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

extension Course {
    
    
    
    var totalPointsReceived: AnyObject {
        get {
            return rAssignment.valueForKeyPath("@sum.pointReceived")!
        }
    }
    
    var totalPointsPossible: AnyObject {
        get {
            return rAssignment.valueForKeyPath("@sum.pointsPossible")!
        }
    }
    
    var assignmentCount: AnyObject {
        get {
            return rAssignment.count
        }
    }
    
    var percentageGrade: Double {
        get {
            //return self.totalPointsPossible.doubleValue / self.totalPointsPossible.doubleValue
            var pr: AnyObject = rAssignment.valueForKeyPath("@sum.pointReceived")!
            var pp: AnyObject = rAssignment.valueForKeyPath("@sum.pointsPossible")!
            var per: Double = (pr.doubleValue/pp.doubleValue) * 100
            println("PER::::: \(per)")
            return per
            
            
        }
    }
    
}