//
//  GoalCell.swift
//  GoalPost
//
//  Created by Omar on 5/21/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    // outlets
    @IBOutlet weak var goalDescribtion_lbl: UILabel!
    @IBOutlet weak var goalType_lbl: UILabel!
    @IBOutlet weak var goalProgress_lbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    
    // functions
    func configureCell(goal: Goal) {
        self.goalDescribtion_lbl.text = goal.goalDescription
        self.goalType_lbl.text = goal.goalType
        self.goalProgress_lbl.text = String(goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }
    
    
    
}
