//
//  DataInfo.swift
//  Discount Calculator
//
//  Created by Vance on 3/13/17.
//  Copyright © 2017 Vance. All rights reserved.
//

import UIKit

class DataInfo {
    // Original Price
    var orgPrice:Float
    func getOrgPrice() -> Float {
            return self.orgPrice
    }
    func setOrgPrice(_ new:Float) {
        self.orgPrice = new
    }
    
    // Dicounted
    var disPrice:Float
    func getDisPrice() -> Float {
        return self.disPrice
    }
    func setDisPrice(_ new:Float) {
        self.disPrice = new
    }
    
    init () {
        self.orgPrice = 0.0
        self.disPrice = 0.0
    }
    
    static let sharedInstance:DataInfo = DataInfo()
}
