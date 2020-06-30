//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Vu Nguyen on 6/27/20.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calMethod: String)?
    
    mutating func set_number(_ number: Double){
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
                case "+/-" : return n * -1
                case "AC" : return 0
                case "%" : return n * 0.01
                case "=" : return perform2NumCal(n2: n)
                default : intermediateCalculation = (n1: n, calMethod: symbol)
            }
        }
        return nil
    }
    
    private func perform2NumCal(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1, let op = intermediateCalculation?.calMethod {
            switch op {
                case "+": return n1 + n2
                case "-": return n1 - n2
                case "×": return n1 * n2
                case "÷": return n1 / n2
                default: fatalError("OP does not match")
            }

        }
        return nil
    }
}
