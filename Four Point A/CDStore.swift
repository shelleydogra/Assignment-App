//
//  CDStore.swift
//  Four Point A
//
//  Created by Shelley on 3/28/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import CoreData

class CDStore: NSObject {
   
    
    // MARK:- Core Data Singleton
    class var studentData: CDStore {

        struct Single {
            static let instance: CDStore = CDStore()
        }
        return Single.instance
    }
    
    // MARK:- STACK
    
    
    
    
    
    
    
}
