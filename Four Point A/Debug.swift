//
//  Debug.swift
//  Four Point A
//
//  Created by Shelley on 4/21/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation


class Debug: NSObject {
    
    class var debugON: Debug {
        
        struct Single {
            static let instance: Debug = Debug()
        }
        return Single.instance
    }
    
    func debugLog(print: AnyObject, sender: AnyObject) {
        let classString: String = NSStringFromClass(sender.classForCoder)
        let seperatedClassString: String = classString.componentsSeparatedByString(".").last!
        
        println("Class: \(seperatedClassString)--> \(print)" )
    }
    
    
    func loggingPrintln<T>(@autoclosure object:  () -> T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
        
        #if DEBUG
            let file = file.lastPathComponent.stringByDeletingPathExtension
            
            println("\(file).\(function)[\(line)]: \(object())")
            
        #endif
    }
    
}