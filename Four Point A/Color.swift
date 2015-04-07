//
//  Color.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

    
extension UIColor {
        convenience init(red: Int, green: Int, blue: Int) {
            
            let RED   = CGFloat(red)/255
            let GREEN = CGFloat(green)/255
            let BLUE  = CGFloat(blue)/255

            self.init(red: RED, green: GREEN, blue: BLUE, alpha: 1.0)
            
        }
}




class Color: UIColor {
    
     struct Scheme1 {
    
        var color: UIColor = UIColor(red: 1, green: 57, blue: 64)
        
        var cellColor = UIColor(red: 16, green: 44, blue: 31)
        
        var lightBackground = UIColor(red: 225, green: 225, blue: 200)
        
        var highlightColor = UIColor(red: 70, green: 129, blue: 147)
        
        var darkBlueColor = UIColor(red: 1, green: 11, blue: 64)
        
        
    }
    
    struct Scheme2 {
    
//    var color: UIColor = UIColor(red: 1, green: 57, blue: 64)
//
//    var cellColor = UIColor(red: 16, green: 44, blue: 31)
//
//    var lightBackground = UIColor(red: 239, green: 240, blue: 234)
//    
//    var highlightColor = UIColor(red: 70, green: 129, blue: 147)
//    
//    var darkBlueColor = UIColor(red: 1, green: 11, blue: 64)
        
    }
}


