//
//  Type.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation
import CoreData

@objc(Type)

class Type: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var rAssignment: NSSet

}
