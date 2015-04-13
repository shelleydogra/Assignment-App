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
    
    var assignment: Assignment!
    
    
    
    
    
    // WE HAVE TO FETCH A COURSE FOR THE APPROPRIATE STUDENT
    lazy var fetchRequest: NSFetchRequest = {
        
        // ENTITY -> Course
        let fr = NSFetchRequest (entityName: "Assignment")
        
        // SORT -> NAME OF COURSE
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        //****** PREDICATE GIVES US THE STUDENT WHO IS TAKING THE COURSE
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // UPDATING UI FOR THE
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell", forIndexPath: indexPath) as! UITableViewCell

        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment

        cell.textLabel?.text = assignment.name
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAddAssignmentVC" {
            let addAssignmentVC = segue.destinationViewController as! AddAssignmentViewController
            
            addAssignmentVC.course = course
        }
    }
    

}
