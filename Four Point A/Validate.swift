//
//  Validate.swift
//  Four Point A
//
//  Created by Shelley on 4/16/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation
import CoreData

class Validate: NSObject {
   
    //Text Field Validation by alert

    func validateAllTextFieldsInCurrentView(viewIn: UIView) -> Bool {
        
        let view = UIView()
        var isValid = false
        for view in viewIn.subviews {
            if view.isKindOfClass(UITextField) {
                let textField: UITextField = view as! UITextField
                if (textField.text == " ") {
                    isValid = false
                } else {
                    isValid = true
                }
            }
        }
        return isValid
}

}