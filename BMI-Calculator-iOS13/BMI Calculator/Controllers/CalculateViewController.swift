//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightSliderVar: UISlider!
    @IBOutlet weak var weightSliderVar: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func weightSlider(_ sender: UISlider) {
         weightValue.text = String(format: "%.0flbs", sender.value)
    }
    @IBAction func heightSlider(_ sender: UISlider) {
        heightValue.text = String(format: "%.2f\"", sender.value)
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destination = segue.destination as! ResultViewController
            destination.bmi = calculatorBrain.getBMIValue( height: heightSliderVar.value, weight: weightSliderVar.value)
            destination.advice = calculatorBrain.getAdvice()
            destination.color = calculatorBrain.getColor()
        }
    }
    
}

