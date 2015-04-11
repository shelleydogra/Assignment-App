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
    
    var color: Color = Color(themeIn: Color.themeEnum.Dark)
    
    var course: Course!


    
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

        
        // REGISTER CUSTOM CELL
        var nib = UINib(nibName: "CourseTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "CourseCell")
        //
        
        
        tableView.delegate = self
        
        
        view.backgroundColor = color.color

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
       
        cell.label1.text = course.name
        cell.gradeLabel.text = "90%"
        
        cell.nextAssignmentLabel.text = "Next Assignment info"
        
        cell.courseImage.image = UIImage(named: "monkey.png")

        return cell
    }

    //ADJUST CELL HEIGHT
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CourseTableViewCell().rowHeight
    }
    // SEGUE

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "toAssignmentTVC" {
//            
//            let cell = sender as! UITableViewCell
//            
//            let indexPath = tableView.indexPathForCell(cell)
//            
//            let course = fetchData().objectAtIndexPath(indexPath!) as! Course
//            
//            let AssignmentTVC = segue.destinationViewController as! CourseTableViewController
//            
//            println("StudentTVC: student.name -> \(course.name)")
//            
//        }
//    }
}