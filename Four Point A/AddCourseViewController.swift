//
//  AddCourseViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AddCourseViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditHoursTextField: UITextField!
    
    let studentData: NSManagedObjectContext = CDStore.studentData.managedObjectContext!
    
    var validate = Validate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }
    
    override func viewWillAppear(animated: Bool) {
        // Will put the focus on the first Text field and bring up the keyboard
        courseNameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // SAVE BUTTON ACTION
    @IBAction func saveButton(sender: AnyObject) {
        
        // INSERT FOR THE course Entity: Course and Context: studentData
        let course = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: studentData) as! Course
        
        // USER INPUT VALIDATION AND FEEDBACK
        switch true {
            case courseNameTextField.text.isEmpty:
                alert("Text Field Empty", withMessage: "Enter Course Name", andButtonTitle: "OK", andhandler: self.courseNameTextField.becomeFirstResponder())
            
            case creditHoursTextField.text.isEmpty:
                alert("Hours Field Empty", withMessage: "Enter Number of Hours", andButtonTitle: "OK", andhandler: self.creditHoursTextField.becomeFirstResponder())
            
            default: // SAVE
                course.name = courseNameTextField.text
                course.creditHours = creditHoursTextField.text.toInt()!
                
                var error: NSError? = nil
                studentData.save(&error)
                
                if(error != nil) {
                    println("error occoured while save studentData: \(error)")
                }
                dismissVC()
        }
        self.studentData.rollback()
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.studentData.rollback()
        dismissVC()
    }
    
    func alert (titleIn: String, withMessage messageIn: String, andButtonTitle buttonTitleIn: String, andhandler handler: AnyObject) {
        
        let textFieldEmptyAlert = UIAlertController(title: titleIn, message: messageIn, preferredStyle: .Alert)
        textFieldEmptyAlert.addAction(UIAlertAction(title: buttonTitleIn, style: .Default, handler: {alertAction in handler}))
        presentViewController(textFieldEmptyAlert, animated: true, completion: nil)
    }
    
    
    
    
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
    }

    func setupUI() {
        courseNameTextField.placeholder  = "Course Name"
        creditHoursTextField.placeholder = "Credit Hrs"
        creditHoursTextField.keyboardType = UIKeyboardType.NumberPad
    }
    

    
    
    
    
    
    

}
