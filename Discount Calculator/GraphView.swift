//
//  GraphView.swift
//  Discount Calculator
//
//  Created by Vance on 3/6/17.
//  Copyright © 2017 Vance. All rights reserved.
//

import UIKit

/*extension CGContext {
    func setFillColor(_ hex:Int) {
        // Mask different values of the hex code
        // 0xFF0000 - Red
        // 0x00FF00 - Green
        // 0x0000FF - Blue
        let redColor:CGFloat = CGFloat((hex >> 16) & 0xFF) / 255.0
        let greenColor:CGFloat = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blueColor:CGFloat = CGFloat(hex & 0xFF) / 255.0
        setFillColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }//context.setFillColor(0x84516D)
}*/

class GraphView: UIView {

    let CalcData = DataInfo.sharedInstance
    
    @IBOutlet weak var printOrgPrice: UILabel! //ok
    @IBOutlet weak var youSaved: UILabel! // ok
    @IBOutlet weak var printSavedPrice: UILabel! //ok
    @IBOutlet weak var printSaved100: UILabel! // ok
    @IBOutlet weak var youPay: UILabel!
    @IBOutlet weak var printPaidPrice: UILabel!
    @IBOutlet weak var printPaid100: UILabel!
    
    override func draw(_ rect: CGRect) {
        
        // Spending/save Calculations
        let org = CalcData.getOrgPrice()
        let paid = CalcData.getDisPrice()
        let saved = org - paid
        let saved100 = saved / org * 100
        let paid100 = 100 - saved100
        
        // Print the result
        printOrgPrice.text = "$" + (NSString(format:"%.2f", org) as String)
        printSavedPrice.text = "$" + (NSString(format:"%.2f", saved) as String)
        printPaidPrice.text = "$" + (NSString(format:"%.2f", paid) as String)
        if org == 0.0 {
            printSaved100.text = "0.00%"
            printPaid100.text = "0.00%"
        }
        else {
            printSaved100.text = (NSString(format:"%.2f", saved100) as String) + "%"
            youPay.text = ""
            printPaidPrice.text = ""
            printPaid100.text = ""
        }
        
        
        
        // Data for color filling.
        let context:CGContext = UIGraphicsGetCurrentContext()!
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let leftGuide:CGFloat = 16.0
        let rightGuide:CGFloat = screenWidth - 32.0
        let topGuide:CGFloat = 80.0
        let botGuide = screenHeight - 136.0
        
        // Fill ORANGE color the entire rect/half-left and "Original Price" section
        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        context.fill(CGRect(x:leftGuide, y:topGuide, width:rightGuide, height:botGuide))
        
        // Fill GREEN color the half-right rect and "You Saved" section
        context.setFillColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0)
        context.fill(CGRect(x:leftGuide + rightGuide / 2, y:topGuide, width:rightGuide / 2, height:botGuide))
        
        // Fill color "You Pay" section
        let yPos = topGuide + (botGuide * CGFloat(saved100 / 100))
        let heightYpos = botGuide - botGuide * CGFloat(saved100 / 100)
        context.setFillColor(red: 0.3, green: 0.4, blue: 0.4, alpha: 1.0)
        context.fill(CGRect(x:leftGuide + rightGuide / 2, y:yPos, width:rightGuide / 2, height:heightYpos))
        
        
        // Draw text "You Pay" section
        let youPayTx = "You pay"
        let paidTx = "$" + (NSString(format:"%.2f", paid) as String)
        let paid100Tx = (NSString(format:"%.2f", paid100) as String) + "%"
        
        let textAttributes = [
            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 16.0),NSForegroundColorAttributeName: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ]
        
        let xPay = screenWidth / 2 + 22.0
        var yPay = yPos
        if saved100 < 20.0 {
            yPay = topGuide + (botGuide * CGFloat(0.4))
        }
        else if paid100 < 20.0 {
            yPay = topGuide + (botGuide * CGFloat(0.8))
        }
        youPayTx.draw(at: CGPoint(x: xPay, y: yPay + 21), withAttributes: textAttributes)
        paidTx.draw(at: CGPoint(x: xPay, y: yPay + 52.0), withAttributes: textAttributes)
        paid100Tx.draw(at: CGPoint(x: xPay, y: yPay + 72.0), withAttributes: textAttributes)
    }

}
