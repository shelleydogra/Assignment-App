//
//  DoubleExtension.swift
//  Four Point A
//
//  Created by Shelley on 5/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation

extension Double {

    //  turncate double to have the desired decimal places
    func decimal(places: String) -> String {
        return NSString(format: "%\(places)f", self) as String
    }
    
}