//
//  AddAssignmentViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/11/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AddAssignmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    let studentData = CDStore.studentData.managedObjectContext!
    
    var assignment: Assignment!
    
    var course: Course!
    
    var AssignmentTVC: AssignmentTableViewController? = nil
    
    var date: NSDate!
    var dateString: String?
    
    @IBOutlet weak var dateSelector: UIDatePicker!
    @IBOutlet weak var pointsPickerView: UIPickerView!
    
    
    @IBOutlet weak var assignmentNameTextField: UITextField!
 
    @IBOutlet weak var dueDateButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateUI()
        delegationHandler()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        println("setupUI for View: \(self.classForCoder.description())")
        assignmentNameTextField.placeholder = "Assignment Name"

        
        
        //set up date picker to only show dates
        dateSelector.datePickerMode = UIDatePickerMode.Date
        
    }
    
    func updateUI() {
        if date == nil {
            dueDateButtonOutlet.setTitle("📅   dueDate", forState: UIControlState.Normal)
        } else {
            dueDateButtonOutlet.setTitle(date?.formattedShort, forState: UIControlState.Normal)
        }

    }
    
    func delegationHandler() {
        pointsPickerView.dataSource = self
        pointsPickerView.delegate = self
        
    }
    
    
    
    @IBAction func saveAssignmentButton(sender: AnyObject) {
        let assignment = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: studentData) as! Assignment
        
        
        if (assignmentNameTextField.text != nil) {
            assignment.name = assignmentNameTextField.text
            assignment.rCourse = self.course!
            assignment.isSubmitted = false
            
            if (date != nil) {
               assignment.dueDate = date!
            }
            
            
            assignment.pointsPossible = 10
           
            debugLog(assignment.pointReceived)
            
            
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
        self.studentData.rollback()
        dismissVC()
    }
    

    
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func assignmentDateFieldAction(sender: UITextField) {
        
        sender.inputView = pointsPickerView
        pointsPickerView.targetForAction("handlePicker:", withSender: self)
        
    }
    
    func hadlePicker(sender: UIPickerView){
        
   
        
    }
    
    // MARK:- DATE SELECTOR METHODS
    
    @IBAction func dateSelectorAction(sender: UIDatePicker) {
        displayDate()
    }
    
    func displayDate() {
        self.date = dateSelector.date
        updateUI()
    }
    
    
    
    
    
    
    // MARK:- PICKER VIEW METHODS
    
    var pickerData = [
        ["0","1","2","3","4","5","6","7","8","9"],
        ["0","1","2","3","4","5","6","7","8","9"], ["/"],
        ["0","1","2","3","4","5","6","7","8","9"],
        ["0","1","2","3","4","5","6","7","8","9"]
    ]
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, pointsPickerView.frame.size.width, 15))
        
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = UIColor.redColor()
        label.alpha = 1.0
        label.text = pickerData[component][row]
        
        return label
    }
    
    
    func debugLog(print: AnyObject) {
        let classString: String = NSStringFromClass(self.classForCoder)
        let seperatedClassString: String = classString.componentsSeparatedByString(".").last!
        
        
        println("Class: \(seperatedClassString)--> \(print)" )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDatePicker" {
            
            //segue VC
            let datePickerVC = segue.destinationViewController as! DatePickerViewController
            
            datePickerVC.date = self.date
        
        }
    }

}
