//
//  DatePickerViewController.swift
//  Four Point A
//
//  Created by Shelley on 4/16/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    

    var date: NSDate!
    var dateString: String?
    
    var AddAssignmentVC: AddAssignmentViewController? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }

    
    func displayDate() {
        selectedDateLabel.text = datePicker.date.formattedMedium
    }
    
    @IBAction func dateChanged(sender: AnyObject) {
        displayDate()
    }

    
    func setupUI() {
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        if (date != nil) {
            datePicker.date = date!
        } else {
            datePicker.date = NSDate()
        }
        
        displayDate()

    }
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        //AddAssignmentVC!.date = datePicker.date
        dismissVC()

    }
    
    override func viewWillDisappear(animated: Bool) {
        AddAssignmentVC!.date = datePicker.date
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissVC()
    }
    
    func incrementDay(dateIn: NSDate) -> NSDate {
        
        var dayComponenet = NSDateComponents()
        dayComponenet.day = 1
        
        var cal = NSCalendar.currentCalendar()
        var tomorrow = cal.dateByAddingComponents(dayComponenet, toDate: dateIn, options: nil)
        
        return tomorrow!
    }
    
    func dismissVC() {
        navigationController?.popViewControllerAnimated(true)
    }
    

}
