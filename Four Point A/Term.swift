//
//  Term.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation
import CoreData

@objc(Term)

class Term: NSManagedObject {

    @NSManaged var creditHours: NSNumber
    @NSManaged var endDate: NSDate
    @NSManaged var gpa: NSNumber
    @NSManaged var name: String
    @NSManaged var startDate: NSDate
    @NSManaged var rCourse: NSSet
    @NSManaged var rStudent: Student

}

extension Term {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.name = "Spring 2015"
        self.gpa = 3.7
    }
}