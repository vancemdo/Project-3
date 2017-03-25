//
//  ResultViewController.swift
//  Discount Calculator
//
//  Created by Van Do on 2/27/17.
//  Copyright © 2017 Van Do. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Define right back swipe.
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleRight))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Swipe back to calcController
    func handleRight(_ sender:UIGestureRecognizer) {
        self.performSegue(withIdentifier: "unwindToCalc", sender: self)
    }

}
