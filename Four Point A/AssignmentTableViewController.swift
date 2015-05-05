//
//  AssignmentTableViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/11/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AssignmentTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    //Context
    let studentData = CDStore.studentData.managedObjectContext!
    
    var course: Course!
    
    var assignment: Assignment?
    
    
    // WE HAVE TO FETCH assignment FOR THE APPROPRIATE Course
    lazy var fetchRequest: NSFetchRequest = {
        
        // ENTITY -> Assignment
        let fr = NSFetchRequest (entityName: "Assignment")
        
        // SORT -> NAME OF Assignment
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        //****** PREDICATE
        //fr.predicate = NSPredicate(format: "takenByStudent.name == %@", self.student.name)
        
        fr.predicate = NSPredicate(format: "rCourse == %@", self.course)
        return fr
        }()
    
    // USING THE FETCHED RESULT WE WILL INSTANTIATE THE RESULTS CONTROLLER
    lazy var fetchedResultsController: NSFetchedResultsController = {
        var frc: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.studentData, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
        }()
    
    // PERFORM FETCH AND RELOAD THE TABLEVIEW TO HAVE THE LATEST VALUES
    func updateUI(){
        fetchedResultsController.performFetch(nil)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelgates()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    func handleDelgates() {
        fetchedResultsController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell", forIndexPath: indexPath) as! UITableViewCell
        
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment
        
        cell.textLabel?.text = assignment.name
        
        cell.detailTextLabel?.text = assignment.dueDate.formattedShort
    }
    
    
    
    
    
    func setupUI() {
      
        
        //setupBackGroundImage()
        
        
    }
    
    func setupBackGroundImage() {
        // background image .alpha() is an extension of UIImage in FILE -> Image.swift
        var bgImage: UIImage = UIImage(named: "bgStarBlue.png")!.alpha(0.6)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
    }
    

    // MARK: - Navigation
    // SEGUE PREPARATION FOR THE DATA GETTING PASSED AS WE SEGUE.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // CURRENT COURSE IS PASSED TO A VAR IN DESTINATION SO THE ASSIGNMENT IS ADD TO THE APPROPRIATE COURSE
        if segue.identifier == "toAddAssignmentVC" {
            let addAssignmentVC = segue.destinationViewController as! AddAssignmentViewController
            
            // PASSING CURRENT course TO ADD ASSIGNMENT VIEW
            addAssignmentVC.course = course
            addAssignmentVC.date = NSDate().dateByAddingTimeInterval(7.days)
        }
    }
    
    
    // MARK:- Editing tables
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let context = self.fetchedResultsController.managedObjectContext
            
            //context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            studentData.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            var error: NSError? = nil
            
            studentData.save(&error)
            
            if(error != nil) {
                println("Error occoured while saving studentData: \(error)")
            }

        }
    }

    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Update:
            let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
            self.configureCell(cell!, atIndexPath: indexPath!)
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            break
            
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        let indexSet = NSIndexSet(index: sectionIndex)
        
        switch type {
        case .Insert:
            tableView.insertSections(indexSet, withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
        default:
            break
        }
    }
 
}
