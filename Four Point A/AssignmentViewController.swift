//
//  AssignmentViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/12/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AssignmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    let studentData = CDStore.studentData.managedObjectContext!
    
    var assignment: Assignment!
    
    
    var course: Course!
    

  
    
    
    
    // Data Fetch
    // WE HAVE TO FETCH A COURSE FOR THE APPROPRIATE STUDENT
    lazy var fetchRequest: NSFetchRequest = {
        
        // ENTITY -> Course
        let fr = NSFetchRequest (entityName: "Student")
        
        // SORT -> NAME OF COURSE
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        //****** PREDICATE GIVES US THE STUDENT WHO IS TAKING THE COURSE
        //fr.predicate = NSPredicate(format: "takenByStudent.name == %@", self.student.name)
        
        //fr.predicate = NSPredicate(format: "ANY student.rCourse.rAssignment == %@", self.student.rCourse.rAssignment)
        
        return fr
        }()
    
    // USING THE FETCHED RESULT WE WILL INSTANTIATE THE RESULTS CONTROLLER
    lazy var fetchedResultsController: NSFetchedResultsController = {
        var frc: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.studentData, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return fetchedResultsController.fetchedObjects?.count ?? 0
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        //let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment
        
        
        // Populate Cell
        cell.textLabel?.text = "Test"
        
        return cell
    }

    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println("row: ")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
