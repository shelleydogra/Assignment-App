//
//  CourseTableViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class CourseTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    //let fetchedStudentEntity = CDFetch(entityNameIn: "Course", sortKeyIn: "name", sortOrderIn: true)
    
    var color: Color = Color(themeIn: Color.theme.Dark)
    
    var course: Course?

    
    
    
    
    //context
    let studentData = CDStore.studentData.managedObjectContext!
    
    lazy var fetchRequest: NSFetchRequest = {
        
        // ENTITY -> Assignment
        let fr = NSFetchRequest (entityName: "Course")
        
        // SORT -> NAME OF Assignment
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        //****** PREDICATE
        //fr.predicate = NSPredicate(format: "takenByStudent.name == %@", self.student.name)
        
        //fr.predicate = NSPredicate(format: "rCourse == %@", self.course)
        return fr
        }()
    
    // USING THE FETCHED RESULT WE WILL INSTANTIATE THE RESULTS CONTROLLER
    lazy var fetchedResultsController: NSFetchedResultsController = {
        var frc: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.studentData, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
        }()

    
    
    
    
    
//    func fetchData() -> NSFetchedResultsController {
//        let frc = fetchedStudentEntity.fetchedResultsController
//        return frc
//    }

    func updateUI() {
        fetchedResultsController.performFetch(nil)
        self.tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        handleDelegates()
        
        ////////// SETUP ////////////

        // REGISTER CUSTOM CELL
        //var nib = UINib(nibName: "CourseTableViewCell", bundle: nil)
        //self.tableView.registerNib(nib, forCellReuseIdentifier: "CourseCell")
    }
    
    func setupUI() {
        setupBackGroundImage()

        //self.tableView.backgroundColor = UIColor.blueColor()
        self.tableView.opaque = true
        //self.tableView.backgroundView = nil;
    }
    
    func handleDelegates() {
        tableView.delegate = self
    }
    
    func setupBackGroundImage() {
        // background image .alpha() is an extension of UIImage in FILE -> Image.swift
        var bgImage: UIImage = UIImage(named: "background.png")!.alpha(1)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
        cell.backgroundColor  = UIColor.clearColor()
        
        
            configureCell(cell, indexPath: indexPath)

        
        return cell
    }

    
    func configureCell(cell: CourseTableViewCell, indexPath: NSIndexPath) {
        
        let course = fetchedResultsController.objectAtIndexPath(indexPath) as! Course
        
        
        cell.courseNameLabel?.text = course.name as String
        cell.courseCellLabel2?.text =  course.creditHours.description + " Hrs."
        cell.countOfAssignmentsDueLabel?.text = course.rAssignment.count.description + " Due"
        
    }

    //ADJUST CELL HEIGHT
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CourseTableViewCell().rowHeight
    }
    
    //MARK:- EDITING TABLE CELLS
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            
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
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Update:
            let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! CourseTableViewCell
            self.configureCell(cell, indexPath: indexPath!)
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
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
    
    
    
  
    
    
    // SEGUE


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAssignmentTVC" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let sCourse = fetchedResultsController.objectAtIndexPath(indexPath!) as! Course
            let AssignmentTVC = segue.destinationViewController as! AssignmentTableViewController
            
            AssignmentTVC.course = sCourse
            
        }
    }

}