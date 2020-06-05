//
//  CalculateBill.swift
//  Tipsy
//
//  Created by Vu Nguyen on 6/4/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

class CalculatorBill {
    var total: Double
    var tip: Double
    var numPeep: Double
    
    init(total: String, tip: String, numPeep: String) {
        let cleanTip = tip.replacingOccurrences(of: "%", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        self.tip = Double(cleanTip) ?? 10
        self.total = Double(total) ?? 0
        self.numPeep = Double(numPeep) ?? 1

    }
    
    func getAmountPerPerson() -> String {
        return String(format: "%.2f", ((self.total + (self.total * self.tip / 100)) / self.numPeep))
    }
}
