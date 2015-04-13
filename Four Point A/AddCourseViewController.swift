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

    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var creditHoursTextField: UITextField!
    
    let studentData: NSManagedObjectContext = CDStore.studentData.managedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        courseNameTextField.placeholder = "Course Name"
        creditHoursTextField.placeholder = "Credit Hrs"
        
        
        
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
        
        if (courseNameTextField.text != nil) {
            course.name = courseNameTextField.text
            course.creditHours = NSNumberFormatter().numberFromString(creditHoursTextField.text)!
        }
        
        var error: NSError? = nil
        studentData.save(&error)
        
        if(error != nil) {
            println("error occoured while save studentData: \(error)")
        }
        
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
