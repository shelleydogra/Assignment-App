//
//  Image.swift
//  Four Point A
//
//  Created by Shelley on 4/21/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import Foundation


//EXTENSION to support alpha for any image.

extension UIImage {
    
    func alpha(alphaValue: CGFloat) -> UIImage {
        
       
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        var currentGraphicsContext = UIGraphicsGetCurrentContext()
        let imageDim = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        
        CGContextScaleCTM(currentGraphicsContext, 1, -1)
        CGContextTranslateCTM(currentGraphicsContext, 0, -imageDim.size.height)
        CGContextSetAlpha(currentGraphicsContext, alphaValue)
        CGContextDrawImage(currentGraphicsContext, imageDim, self.CGImage)

        var adjustedImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext()
        
        
        return adjustedImage
    }
}