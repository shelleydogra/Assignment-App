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

    // Core Data Context
    let studentData = CDStore.studentData.managedObjectContext!
    
    var assignment: Assignment!
    var course: Course!
    
    var AssignmentTVC: AssignmentTableViewController? = nil
    
    var date: NSDate!
    var dateString: String?
    
    var localPointsPossible: Int? = 0
    var localPointsReceived: Int? = 0
    
    // OUTLETS
    @IBOutlet weak var dateSelector: UIDatePicker!
    @IBOutlet weak var pointsPickerView: UIPickerView!
    @IBOutlet weak var assignmentNameTextField: UITextField!
    @IBOutlet weak var dueDateButtonOutlet: UIButton!
    @IBOutlet weak var setDateButton: UIButton!

    
    override func viewWillAppear(animated: Bool) {
        // Will put the focus on the first Text field and bring up the keyboard
        assignmentNameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        delegationHandler()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupUI() {
        println("setupUI for View: \(self.classForCoder.description())")
        assignmentNameTextField.placeholder = "Assignment Name"


        //temp
        pointsPickerView.hidden = true
        
        //set up date picker to only show dates
        dateSelector.datePickerMode = UIDatePickerMode.Date
        
        //load date into datepicker if it comes in EDIT mode from previous view controller
        if date != nil {
            dateSelector.date = date
            dueDateButtonOutlet.setTitle(date?.formattedShort, forState: UIControlState.Normal)
        } else {
            dateSelector.date = NSDate()
            dueDateButtonOutlet.setTitle("📅   Due Date", forState: UIControlState.Normal)
        }
        
        dateSelector.hidden = true
        setDateButton.hidden = true
        setDateButton.setTitle("SET", forState: UIControlState.Normal)
    }
    
    func updateUI() {
        if date == nil {
            dueDateButtonOutlet.setTitle("📅   Due Date", forState: UIControlState.Normal)
        } else {
            dueDateButtonOutlet.setTitle(date?.formattedShort, forState: UIControlState.Normal)
        }
    }
    
    func delegationHandler() {
        pointsPickerView.dataSource = self
        pointsPickerView.delegate = self
    }
    
    
    @IBAction func dueDateButtonAction(sender: UIButton) {
        dateSelector.hidden = !dateSelector.hidden
        setDateButton.hidden = false
        dueDateButtonOutlet.hidden = true
    }
    
    @IBAction func setDateButtonAction(sender: UIButton) {
        setDateButton.hidden = !setDateButton.hidden
        dateSelector.hidden = true
        dueDateButtonOutlet.hidden = false
    }
    
    @IBAction func pointsButton(sender: AnyObject) {
        dateSelector.hidden = true
        pointsPickerView.hidden = false
    }
    
    
    @IBAction func saveAssignmentButton(sender: AnyObject) {
        let assignment = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: studentData) as! Assignment
        
        switch true {
        case assignmentNameTextField.text.isEmpty:
            alert("Assignment Name Empty", withMessage: "Enter Assignment", andButtonTitle: "OK", andhandler: self.assignmentNameTextField.becomeFirstResponder())
            
        default: //Save
            assignment.name = assignmentNameTextField.text
            assignment.rCourse = self.course
            assignment.isSubmitted = false
            
            if (date != nil) {
                assignment.dueDate = date!
            }
            assignment.pointsPossible = localPointsPossible!
            
            assignment.pointReceived = localPointsReceived!
            if (assignment.pointReceived != 0) {
                assignment.isSubmitted = true
            }
         
            var error: NSError? = nil
            studentData.save(&error)
            
            if(error != nil) {
                println("Error occoured while saving studentData: \(error)")
            }
            dismissVC()
        }
        self.studentData.rollback()
    }
    
        
//        if (assignmentNameTextField.text != nil) {
//            assignment.name = assignmentNameTextField.text
//            assignment.rCourse = self.course!
//            assignment.isSubmitted = false
//            
//            if (date != nil) {
//               assignment.dueDate = date!
//            }
//            
//            
//            assignment.pointsPossible = 10
//            debugLog(assignment.pointReceived)
//            
//        }
//        
//        var error: NSError? = nil
//        studentData.save(&error)
//        
//        if(error != nil) {
//            println("error occoured while saving studentData: \(error)")
//        }
//        
//        AssignmentTVC?.course = assignment.rCourse
//        
//        dismissVC()

//    }

    
    
    
    
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.studentData.rollback()
        dismissVC()
    }
    

    
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func alert (titleIn: String, withMessage messageIn: String, andButtonTitle buttonTitleIn: String, andhandler handler: AnyObject) {
        
        let textFieldEmptyAlert = UIAlertController(title: titleIn, message: messageIn, preferredStyle: .Alert)
        textFieldEmptyAlert.addAction(UIAlertAction(title: buttonTitleIn, style: .Default, handler: {alertAction in handler}))
        presentViewController(textFieldEmptyAlert, animated: true, completion: nil)
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
        ["0","1","2","3","4","5","6","7","8","9"],
        ["0","1","2","3","4","5","6","7","8","9"], ["/"],
        ["0","1","2","3","4","5","6","7","8","9"],
        ["0","1","2","3","4","5","6","7","8","9"],
        ["0","1","2","3","4","5","6","7","8","9"]
    ]
    

    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }

//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch (component) {
//        case 0:
//            switch (row) {
//            case 0:
//                //println("0,0")
//                println("oai: \(pointsPickerView.selectedRowInComponent(3).toIntMax()) ")
//            case 1:
//                println("0,1")
//            default:
//                println("column 0 default")
//            
//            }
//        case 1:
//            switch (row) {
//            case 0:
//                println("1,0")
//            case 1:
//                println("1,1")
//            default:
//                println("column 0 default")
//        }
//        default:
//            println("overall")
//        }
//    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        localPointsReceived = intValueFromComponents(0, andComponent: 1, andComponent: 2).pickerInteger
        localPointsPossible = intValueFromComponents(4, andComponent: 5, andComponent: 6).pickerInteger
        
        println("\(localPointsReceived!) out of \(localPointsPossible!)")
    }
    
    // 3 digit string concatenated from string -> Int and String (Touple)
    func intValueFromComponents(component1: Int, andComponent  component2: Int, andComponent  component3: Int) -> (pickerInteger: Int,pickerString: String) {
        
        var sumString: String = "\(pointsPickerView.selectedRowInComponent(component1).toIntMax())" +
                                "\(pointsPickerView.selectedRowInComponent(component2).toIntMax())" +
                                "\(pointsPickerView.selectedRowInComponent(component3).toIntMax())"
        return (sumString.toInt()!, sumString)
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
        label.textColor = UIColor.blueColor()
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
