//
//  SemesterViewController.swift
//  Four Point A
//
//  Created by Shelley on 5/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import CoreData

class SemesterViewController: UIViewController {
    
    
    
    @IBOutlet weak var termNameLabel: UILabel!
    @IBOutlet weak var creditHoursLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!

    
    let studentData = CDFetch(entityNameIn: "Term", sortKeyIn: "name", sortOrderIn: true)
    
    func coreData() -> NSFetchedResultsController {
        let frc = studentData.fetchedResultsController
        return frc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setupUI() {
        //heading
        self.title = "Semester"
        
        

        
    }
    
    
    
}
