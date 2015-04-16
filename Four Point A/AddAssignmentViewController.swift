//
//  AddAssignmentViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/11/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AddAssignmentViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let studentData = CDStore.studentData.managedObjectContext!
    
    //let assignment: Assignment? = nil
    
    var assignment: Assignment!
    
    var course: Course!
    //var course: Course? = nil
    
    var AssignmentTVC: AssignmentTableViewController? = nil
    

    
    @IBOutlet weak var pointsPickerView: UIPickerView!
    
    @IBOutlet weak var assignmentDueDate: UITextField!
    
    @IBOutlet weak var assignmentNameTextField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup text fields
        // assignment name
        assignmentNameTextField.placeholder = "Assignment Name"
        
        
        
        //pointsPickerView.selectRow(6, inComponent: 0, animated: true)
        
        pointsPickerView.dataSource = self
        pointsPickerView.delegate = self
        
        
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
            assignment.isSubmitted = false
            assignment.pointReceived = 9
            assignment.pointsPossible = 10
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
    
    @IBAction func assignmentDateFieldAction(sender: UITextField) {
        
        sender.inputView = pointsPickerView
        pointsPickerView.targetForAction("handlePicker:", withSender: self)
        
        
    }
    
    func hadlePicker(sender: UIPickerView){
        assignmentDueDate.text = sender.description
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

}
