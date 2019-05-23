//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Omar on 5/22/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    
    // outlets
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    // vars and lets
    var goalDescription: String!
    var goalType: GoalType!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pointsTextField.delegate = self
        createGoalBtn.bindToKeyboard()
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    
    
    @IBAction func creatGoalBtnPressed(_ sender: UIButton) {
        if pointsTextField.text == "" || pointsTextField.text == "0" {
            return
        } else {
            self.save { (complete) in
                if complete {
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    //MARK: - saving the goal function
    func save(completion: (_ finished: Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!) ?? 0
        goal.goalProgress = Int32(0)
        
        do{
            try managedContext.save()
            print("SUCCESSFULLY MADE IT!!!!")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    //...
}
