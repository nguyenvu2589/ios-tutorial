//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalAmount: UITextField!
    @IBOutlet weak var numberOfSplit: UILabel!
    
    @IBOutlet weak var zeroPercent: UIButton!
    @IBOutlet weak var tenPercent: UIButton!
    @IBOutlet weak var twentyPercent: UIButton!
    @IBOutlet weak var customPercent: UITextField!
    
    var tipPercent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        // Do any additional setup after loading the view.
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    @IBAction func uiStepper(_ sender: UIStepper) {
        numberOfSplit.text = String(format: "%.0f", sender.value)
    }

    func deselectTipPercentButton(){
        zeroPercent.isSelected = false
        tenPercent.isSelected = false
        twentyPercent.isSelected = false
    }
    func customPercentSelecte(){
        customPercent.backgroundColor = #colorLiteral(red: 0.1444596052, green: 0.6898921728, blue: 0.4196200371, alpha: 1)
        customPercent.textColor = #colorLiteral(red: 0.8418707252, green: 0.9764023423, blue: 0.9225302339, alpha: 1)
    }
    func customPercentDeSelect(){
        customPercent.backgroundColor = #colorLiteral(red: 0.8418707252, green: 0.9764023423, blue: 0.9225302339, alpha: 1)
        customPercent.textColor = #colorLiteral(red: 0.1444596052, green: 0.6898921728, blue: 0.4196200371, alpha: 1)
        customPercent.text = ""
    }
    
    @IBAction func tipSelector(_ sender: UIButton) {
        view.endEditing(true)
        deselectTipPercentButton()
        customPercentDeSelect()
        
        sender.isSelected = true
        tipPercent = sender.currentTitle
        
    }
    // add $ sign to total amount after user enter
    @IBAction func totalAmountSelector(_ sender: UITextField) {
//        let charset = CharacterSet(charactersIn: "$")
//        if (sender.text != nil){
//            if let _ = sender.text!.rangeOfCharacter(from: charset, options: .caseInsensitive) {
//               print("hey")
//            }
//            else {
//                sender.text = "$ " + sender.text!
//            }
//
//        }
    }
    
    // add % for custom tips
    @IBAction func customTipSelector(_ sender: UITextField) {
        if (sender.text != nil || sender.text != "") {
            deselectTipPercentButton()
            customPercentSelecte()
            tipPercent = sender.text
        }
//        print(sender.title)
//        if (sender.text != nil && ((sender.text?.contains("%")) != nil) ){
//           sender.text! += "%"
//        }
        
    }
    
    @IBAction func calculateTips(_ sender: UIButton) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destination = segue.destination as! ResultViewController
            destination.tipPercent = tipPercent ?? "10%"
            destination.numberOfSplit = numberOfSplit.text ?? "1"
            let cal = CalculatorBill(total: totalAmount.text ?? "0", tip: tipPercent ?? "10%", numPeep: numberOfSplit.text ?? "1" )
            
            destination.amountPerPerson = cal.getAmountPerPerson()
                
        }
    }
    
}

/*
 dollar sign for total bill and custom
 */
