//
//  CalculatorModel.swift
//  BMI Calculator
//
//  Created by Vu Nguyen on 6/3/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    mutating func getBMIValue(height: Float, weight: Float) -> String{
        var bmiValue = weight / pow( (height * 12), 2) * 703
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "EAT MORE !!!", color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        }
        else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "You GUD !!!", color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        }
        else {
            bmi = BMI(value: bmiValue, advice: "You might wanna hold on that cheeses", color: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        }
        return String(format: "%.2f", bmi!.value)
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
