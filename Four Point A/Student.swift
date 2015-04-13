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

    class var sharedInstance: Student? {
        struct Static {
            static var instance: Student?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Student()
        }
        
        return Static.instance!
    }
    

    
    
}
