//
//  CDFetch.swift
//  Four Point A
//
//  Created by Shelley on 3/21/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.



import UIKit
import Foundation
import CoreData


class CDFetch: NSObject, NSFetchedResultsControllerDelegate {

    let studentData = CDStore.studentData.managedObjectContext!
    
    var entity: String!
    
    var sortKey: String!
    
    var sortOrder: Bool!
    
    
    //Default Constructor
    override init(){
        
    }
    
    required init(entityNameIn: String) {
        entity = entityNameIn
    }
    
    
    // Constructor with 2 arguments
    convenience init(entityNameIn: String, sortKeyIn: String) {
        self.init(entityNameIn: entityNameIn)
        sortKey = sortKeyIn
    }
    
    
    // Constructor with 3 arguments
    convenience init(entityNameIn: String, sortKeyIn: String, sortOrderIn: Bool) {
        self.init(entityNameIn: entityNameIn, sortKeyIn: sortKeyIn)
        sortOrder = sortOrderIn
    }
    
    // FETCH
    
    lazy var fetchRequest: NSFetchRequest = {
        let fr = NSFetchRequest (entityName: self.entity)
        fr.sortDescriptors = [NSSortDescriptor(key: self.sortKey, ascending: self.sortOrder)]
        
        return fr
        }()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        var frc: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.studentData, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
        }()
 
    func getContext() -> NSManagedObjectContext {
        return studentData
    }
    
    
}
