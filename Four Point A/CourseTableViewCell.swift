//
//  CourseTableViewCell.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var nextAssignmentLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var courseImage: UIImageView!
    
    let rowHeight: CGFloat = 100
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    
    }

    
}
