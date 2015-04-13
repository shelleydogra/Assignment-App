//
//  AddAssignmentViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/11/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AddAssignmentViewController: UIViewController {

    let studentData = CDStore.studentData.managedObjectContext!
    
    //let assignment: Assignment? = nil
    
    var assignment: Assignment!
    
    var course: Course!
    //var course: Course? = nil
    
    var AssignmentTVC: AssignmentTableViewController? = nil
    

    
    @IBOutlet weak var assignmentNameTextField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup text fields
        // assignment name
        assignmentNameTextField.placeholder = "Assignment Name"
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAssignmentButton(sender: AnyObject) {
        let assignment = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: studentData) as! Assignment
        
        
        if (assignmentNameTextField.text != nil) {
            assignment.name = assignmentNameTextField.text
            assignment.rCourse = self.course!
        }
        
        var error: NSError? = nil
        studentData.save(&error)
        
        if(error != nil) {
            println("error occoured while saving studentData: \(error)")
        }
        
        AssignmentTVC?.course = assignment.rCourse
        
        dismissVC()

    }

    @IBAction func cancelButton(sender: AnyObject) {
        dismissVC()
    }
    

    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
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
