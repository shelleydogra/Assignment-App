//
//  CourseTableViewCell.swift
//  Four Point A
//
//  Created by Shelley on 4/6/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!

    @IBOutlet weak var courseCellLabel2: UILabel!
    @IBOutlet weak var gradePercentageLabel: UILabel!
    
    @IBOutlet weak var countOfAssignmentsDueLabel: UILabel!
    //@IBOutlet weak var courseImage: UIImageView!
    
    let rowHeight: CGFloat = 100

    override func awakeFromNib() {
        super.awakeFromNib()
        courseNameLabel.minimumScaleFactor = CGFloat(0.70)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
