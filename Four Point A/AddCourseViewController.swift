//
//  AddCourseViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class AddCourseViewController: UIViewController, UITextFieldDelegate {

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
    
    @IBAction func saveButton(sender: AnyObject) {
        
        let course = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: studentData) as! Course
        
        if ( courseNameTextField.text != nil &&
            creditHoursTextField.text != nil ) {
            
            course.name = courseNameTextField.text
            course.creditHours = NSNumberFormatter().numberFromString(creditHoursTextField.text)!
        
                
            var error: NSError? = nil
            studentData.save(&error)
                
            if(error != nil) {
                println("error occoured while save studentData: \(error)")
            }
                
            dismissVC()
        }

        
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissVC()
    }
    
//    func findFisrtEmptyTextField() -> UITextField {
//        let view = self.view
//        for view in self.view.subviews {
//            if view.isKindOfClass(UITextField) {
//                let textField: UITextField = view as! UITextField
//                if ( textField.text == nil) {
//                    return textField
//                }
//            }
//        }
//    }
    
    func validateAllTextFieldsInCurrentView() -> (validity: Bool, txtField: UITextField ){
        
        let view = UIView()
        var valid = false
        
        for view in self.view.subviews {
            if view.isKindOfClass(UITextField) {
                let textField: UITextField = view as! UITextField
                if (textField.text != nil) {
                    valid = true
                } else {
                    valid = false
                    println("tf: \(textField.description)")
                    return(valid, textField)
                }
            }
        }
        return (valid, courseNameTextField)
    }

    
    func dismissVC(){
        navigationController?.popViewControllerAnimated(true)
    }

    func setupUI() {
        courseNameTextField.placeholder  = "Course Name"
        creditHoursTextField.placeholder = "Credit Hrs"
    }
    

    
    
    
    
    
    

}
