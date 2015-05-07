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

    // MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var assignmentNameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var daysLeftStaticLabel: UILabel!
    

    
    
    let textCellIdentifier = "TextCell"
    
    let studentData = CDStore.studentData.managedObjectContext!

    var assignment: Assignment!
    
    var debug: Debug?
    

    
    
    // MARK: -
    // WE HAVE TO FETCH A COURSE FOR THE APPROPRIATE STUDENT
    lazy var fetchRequest: NSFetchRequest = {
        // ENTITY -> Assignment
        let fr = NSFetchRequest (entityName: "Assignment")
        
        // SORT -> NAME OF COURSE
        fr.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]
        
        //****** PREDICATE GIVES US THE Assignment with predicate
        
        let submittedPredicate = NSPredicate(format: "isSubmitted == 0")
        
        
        //fr.predicate = NSCompoundPredicate.andPredicateWithSubpredicates([submittedPredicate, sumPredicate])
        fr.predicate = submittedPredicate
        return fr
        }()
    
    // USING THE FETCHED RESULT WE WILL INSTANTIATE THE RESULTS CONTROLLER
    lazy var fetchedResultsController: NSFetchedResultsController = {
        var frc: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.studentData, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
        }()
    
        func updateUI() {
            fetchedResultsController.performFetch(nil)
            self.tableView.reloadData()
            
            if (fetchedResultsController.fetchedObjects?.count == 0) {
                setupUI()
            }
            
        }

    
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(true)
            updateUI()
        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        delegationHandler()
    

        // MARK:- DATE TESTING
        // MARK:-
        ///////////////////////////////// TESTing Date/////////////////////////////////

        
        let date = NSDate().dateByAddingTimeInterval(21.days)


        
    
        
        ///////////////////////////////// TESTing /////////////////////////////////////

    }
    
    
    // MARK:-  TABLEVIEW Methods
    
    
    // DIVIDES UP THE TABLE INTO GROUPS
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // # OF ROWS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // COUNT OF OBJECTS FETCHED BUT IF NIL (??) THEN RETURN 0
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // SETUP PROTOTYPE CELL
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! AssignmentTableViewCell
       
        // GRAB THE CURRENT OBJECT FETCHED
        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment
        
        
        // Populate Cell
        cell.assignmentNameLabel.text = assignment.name
        cell.dueDateLabel.text = assignment.dueDate.formattedMedium
        cell.assignmentWeight.text = "weight.."
        
        
        // Handle button press in within cell
        var notSubmittedImage: UIImage = UIImage(named: "icon-42-target-1.png")!
        var submittedImage: UIImage = UIImage(named: "icon-42-target.png")!
        if (assignment.isSubmitted == false) {
            cell.submitButtonOutlet.setBackgroundImage(notSubmittedImage, forState: UIControlState.Normal)
        } else {
            cell.submitButtonOutlet.setBackgroundImage(submittedImage, forState: UIControlState.Normal)
        }
        cell.submitButtonOutlet.addTarget(self, action: "changeState:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.submitButtonOutlet.addTarget(self, action: "changeBackState:", forControlEvents: UIControlEvents.TouchDragExit)
        
        return cell
    }

    func changeState(sender: UIButton) {
        
        //get a handle on core data to save changes
        
        var pointInSuperView: CGPoint = sender.superview!.convertPoint(sender.center, toView: self.tableView)

        
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(pointInSuperView)!
        
        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment

        assignment.isSubmitted = 1
      
        //save
        var error: NSError? = nil
        studentData.save(&error)
        
        if (error != nil) {
            println("Error while saving in AssignmentVC: \(error)")
        }
        
        self.tableView.reloadData()

    }
    
    func changeBackState(sender: UIButton) {
        
        //get a handle on core data to save changes

        var pointInSuperView: CGPoint = sender.superview!.convertPoint(sender.center, toView: self.tableView)
        
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(pointInSuperView)!
        
        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment
        
        assignment.isSubmitted = 0
        
        //save
        var error: NSError? = nil
        studentData.save(&error)
        
        if (error != nil) {
            println("Error while saving in AssignmentVC: \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    // MARK:-  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let assignment = fetchedResultsController.objectAtIndexPath(indexPath) as! Assignment
        
        
        assignmentNameLabel.text = assignment.name
        courseNameLabel.text = assignment.rCourse.name
        
        if (assignment.daysLeft >= 0) {
            daysLeftLabel.text = String(assignment.daysLeft)
        } else {
            daysLeftLabel.text = "Overdue by " + String(abs(assignment.daysLeft)) + " days"
        }
        
        daysLeftStaticLabel.text = " Days Left"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // INITIAL VIEW METHODS
    func setupUI() {
        println("setupUI for View: \(self.classForCoder.description())")
        assignmentNameLabel.attributedText = NSAttributedString(string: "Assignment")
        assignmentNameLabel.textAlignment = NSTextAlignment.Center
        
        // Course Name Label Initial setup
        courseNameLabel.attributedText = NSAttributedString(string: "Course")
        courseNameLabel.textAlignment = NSTextAlignment.Center
        courseNameLabel.textColor = UIColor.whiteColor()
        
        daysLeftStaticLabel.text = " Days Left"
        
        tableView.backgroundColor = UIColor.clearColor()
        
        daysLeftLabel.text = " "
        setupBackGroundImage()
 
    }
    
    func setupBackGroundImage() {
        // background image .alpha() is an extension of UIImage in FILE -> Image.swift
        var bgImage: UIImage = UIImage(named: "background.png")!.alpha(1)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
    }
    
    
    func delegationHandler() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}
