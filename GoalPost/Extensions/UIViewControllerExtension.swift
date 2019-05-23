//
//  UIViewControllerExtension.swift
//  GoalPost
//
//  Created by Omar on 5/22/19.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // to present the next view controller from the right side
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    //..
    
    // to dismiss the view controller to the left side
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    //..
}
