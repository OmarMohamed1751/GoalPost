//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Omar on 5/22/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    // outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var LongTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // vars and lets
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        goalTextView.delegate = self
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        LongTermBtn.setDeselectedColor()
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = nil
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    //MARK: - short and long term btns set up
    @IBAction func shortTermBtnPressed(_ sender: UIButton) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        LongTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: UIButton) {
        goalType = .longTerm
        LongTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    //...
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if goalTextView.text.isEmpty || goalTextView.text == "What Is Your Goal?" {
           return
        } else{
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else{return}
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentDetail(finishGoalVC)
        }
    }
    
}
