//
//  Assignment.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation
import CoreData

@objc(Assignment)

class Assignment: NSManagedObject {

    @NSManaged var dueDate: NSDate
    @NSManaged var isSubmitted: NSNumber
    @NSManaged var name: String
    @NSManaged var pointReceived: NSNumber
    @NSManaged var pointsPossible: NSNumber
    @NSManaged var rCourse: Course
    @NSManaged var rType: NSSet

    
    
    
    
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.pointReceived = 666
    }
    

}
