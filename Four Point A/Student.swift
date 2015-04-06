//
//  Student.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation
import CoreData

@objc(Student)

class Student: NSManagedObject {

    @NSManaged var gpa: NSNumber
    @NSManaged var name: String
    @NSManaged var rTerm: NSSet

}
