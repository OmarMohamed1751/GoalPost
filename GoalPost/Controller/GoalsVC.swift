//
//  GoalsVC.swift
//  GoalPost
//
//  Created by Omar on 5/21/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // vars and lets
    var goals: [Goal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalBtnPressed(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") as? CreateGoalVC else{return}
        presentDetail(createGoalVC)
    }
    
    

}

//MARK: - table view set up
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else{return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    // make the cell editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    //..
    
    //MARK: - add delete action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD A POINT!") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        
        return [deleteAction, addAction]
    }
    //...
    
}
//...

//MARK: - fetching data and deleting it + making progress lable work
extension GoalsVC {
    // fetching
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data")
            completion(true)
        } catch {
            debugPrint("Couldn't fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    //..
    
    // deleting
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
            print("Goal Removed!")
        } catch {
            debugPrint("Couldn't remove: \(error.localizedDescription)")
        }
    }
    //..
    
    // progress lbl function
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        do {
            try managedContext.save()
            print("Goal progress updated")
        } catch {
            debugPrint("Couldn't set progress: \(error.localizedDescription)")
        }
    }
    //..
    
}
//...



