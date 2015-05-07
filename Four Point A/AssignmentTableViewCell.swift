//
//  AssignmentTableViewCell.swift
//  Four Point A
//
//  Created by Shelley on 5/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.backgroundColor = UIColor.lightGrayColor()
    }

}
