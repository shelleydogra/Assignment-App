//
//  Course.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation
import CoreData

@objc(Course)

class Course: NSManagedObject {

    @NSManaged var creditHours: NSNumber
    @NSManaged var name: String
    @NSManaged var pointsPossible: NSNumber
    @NSManaged var pointsReceived: NSNumber
    @NSManaged var weight: NSNumber
    @NSManaged var rAssignment: NSSet
    @NSManaged var rTerm: Term

}
