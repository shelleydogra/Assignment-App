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

     var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    //var context: NSManagedObjectContext?
    
    var managedObjectContext = NSManagedObjectContext()
    var entityName = ""
    var sortOption: String = ""
    var sortOrder:  Bool   = true
    
    required init(entityNameIn: String, sortOptionIn: String, sortOrderIn: Bool) {
        entityName = entityNameIn
        sortOption = sortOptionIn
        sortOrder = sortOrderIn
    }
    
    var frc = NSFetchedResultsController()
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func listFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        let sortDescriptor = NSSortDescriptor(key: sortOption, ascending: sortOrder)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
}
