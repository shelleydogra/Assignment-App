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

    var fetchedStudentEntity = CDFetch(entityNameIn: "Course", sortKeyIn: "name", sortOrderIn: true)
    
    var color: Color = Color(themeIn: Color.theme.Dark)
    
    var course: Course?

    
    func fetchData() -> NSFetchedResultsController {
        let frc = fetchedStudentEntity.fetchedResultsController
        return frc
    }
    

    func updateUI() {
        fetchData().performFetch(nil)
        self.tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        ////////// SETUP ////////////

        // REGISTER CUSTOM CELL
        //var nib = UINib(nibName: "CourseTableViewCell", bundle: nil)
        //self.tableView.registerNib(nib, forCellReuseIdentifier: "CourseCell")
    }
    
    func setupUI() {
        tableView.delegate = self
        view.backgroundColor = color.lightBackground
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
    
        return fetchData().fetchedObjects?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
        
        let course = fetchData().objectAtIndexPath(indexPath) as! Course
    
        cell.courseNameLabel?.text = course.name
        cell.courseCellLabel2?.text =  course.creditHours.description + " Hrs."
        cell.countOfAssignmentsDueLabel?.text = course.rAssignment.count.description + " Due"

        
        return cell
    }


    
    //ADJUST CELL HEIGHT
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CourseTableViewCell().rowHeight
    }
    
 
    
    // SEGUE
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! CourseTableViewCell
//        
//        self.performSegueWithIdentifier("toAssignmentTVC", sender: cell)
//    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toAssignmentTVC" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let sCourse = fetchData().objectAtIndexPath(indexPath!) as! Course
            let AssignmentTVC = segue.destinationViewController as! AssignmentTableViewController
            
            AssignmentTVC.course = sCourse
            
        }
    }

}