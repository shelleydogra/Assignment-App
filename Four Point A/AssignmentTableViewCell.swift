//
//  AssignmentTableViewCell.swift
//  Four Point A
//
//  Created by Shelley on 5/7/15.
//  Copyright (c) 2015 Shelley Dogra. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var assignmentWeight: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var assignmentNameLabel: UILabel!
    
    
    @IBOutlet weak var submitButtonOutlet: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
