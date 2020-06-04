//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Vu Nguyen on 6/3/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    var bmi: String?
    var advice: String?
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = self.bmi
        adviceLabel.text = self.advice
        view.backgroundColor = self.color
    }
    

    @IBAction func recalculateButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}
