//
//  Color.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit
import Foundation

    
extension UIColor {
        convenience init(red: Int, green: Int, blue: Int) {
            
            let RED   = CGFloat(red)/255
            let GREEN = CGFloat(green)/255
            let BLUE  = CGFloat(blue)/255

            self.init(red: RED, green: GREEN, blue: BLUE, alpha: 1.0)
        }
}

class Color: UIColor {
    
    var color:           UIColor!
    var cellColor:       UIColor!
    var lightBackground: UIColor!
    var highlightColor:  UIColor!
    var darkBlueColor:   UIColor!
    var textColor:       UIColor!
    
    var themeToSet = themeEnum.Dark
    
    enum themeEnum {
        case Dark
        case Dim
        case Light
    }

    override init(){
        super.init()
         themeToSet = themeEnum.Dark
    }
    
    convenience init(themeIn: themeEnum) {
        self.init()
        
        themeToSet = themeIn

        if (themeToSet == themeEnum.Light){
            lightTheme()
        } else if (themeToSet == .Dark) {
            darkTheme()
        } else {
            dimTheme()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func darkTheme(){
         color              = UIColor(red: 200, green: 57,  blue: 64 )
         cellColor          = UIColor(red: 16,  green: 44,  blue: 31 )
         lightBackground    = UIColor(red: 225, green: 225, blue: 200)
         highlightColor     = UIColor(red: 70,  green: 129, blue: 147)
         darkBlueColor      = UIColor(red: 1,   green: 11,  blue: 64 )
        textColor           = UIColor.lightTextColor()
    }
    
    func dimTheme() {
        color           = UIColor.lightGrayColor()
        cellColor       = UIColor.blueColor     ()
        lightBackground = UIColor.yellowColor   ()
        highlightColor  = UIColor.darkGrayColor ()
        darkBlueColor   = UIColor.brownColor    ()
        textColor       = UIColor.lightTextColor()
    }
    
    func lightTheme() {
        color           = UIColor.lightGrayColor()
        cellColor       = UIColor.blueColor     ()
        lightBackground = UIColor.yellowColor   ()
        highlightColor  = UIColor.darkGrayColor ()
        darkBlueColor   = UIColor.brownColor    ()
        textColor       = UIColor.darkTextColor()
    }
    

}


