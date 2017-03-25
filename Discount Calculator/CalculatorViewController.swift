//
//  CalculatorViewController.swift
//  Discount Calculator
//
//  Created by Van Do on 2/27/17.
//  Copyright © 2017 Van Do. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    let list = DataInfo.sharedInstance
    
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var dollarOffTF: UITextField!
    @IBOutlet weak var discountTF: UITextField!
    @IBOutlet weak var otherDisTF: UITextField!
    @IBOutlet weak var taxTF: UITextField!
    @IBOutlet weak var orgPrice: UILabel!
    @IBOutlet weak var disPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Make swipe gesture, handleSwipe is  a defined function
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Swipe Func handleSwipe()
    func handleSwipe(_ sender:UIGestureRecognizer) {
        self.performSegue(withIdentifier: "showResult", sender: self)
    }
    
    
    @IBAction func receiptCal(_ sender: UIButton) {
        let priceStr = String(priceTF.text!)!
        let dollarOffStr = String(dollarOffTF.text!)!
        let discountStr = String(discountTF.text!)!
        let otherDisStr = String(otherDisTF.text!)!
        let taxStr = String(taxTF.text!)!
        
        if let priceFl = Float(priceStr), let dollarOffFl = Float(dollarOffStr), let discountFl = Float(discountStr), let otherDisFl = Float(otherDisStr), let taxFl = Float(taxStr) {
            var orgPriceFl = priceFl + priceFl * taxFl / 100
            var disPriceFl = priceFl - dollarOffFl - priceFl * ((discountFl + otherDisFl) / 100 ) + priceFl * taxFl / 100
            if orgPriceFl < 0.0 {
                    orgPriceFl = 0.0
            }
            if disPriceFl < 0.0 {
                disPriceFl = 0.0
            }
            orgPrice.text = "Original Price $" + (NSString(format:"%.2f", orgPriceFl) as String)
            disPrice.text = "Discount Price $" + (NSString(format:"%.2f", disPriceFl) as String)
            list.setOrgPrice(orgPriceFl)
            list.setDisPrice(disPriceFl)
        }
        else {
            orgPrice.text = "Invalid input(s)!"
            disPrice.text = ""
        }
    }
    
    // Enable unwinding
    @IBAction func unwindToCalc(segue:UIStoryboardSegue) {}
}
