//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftDice: UIImageView!
    @IBOutlet weak var rightDice: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func randomize(len: Int) -> Int {
        return Int.random(in: 0 ... len )
        
    }
    @IBAction func rollButton(_ sender: UIButton) {
        let diceList = [ #imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
        leftDice.alpha = 1
        rightDice.alpha = 1
        let left = randomize(len:   diceList.count)
        let right = randomize(len: diceList.count)
        if left == diceList.count{
            leftDice.alpha = 0
        }
        else if ((right == diceList.count) && (leftDice.alpha != 0)){
            rightDice.alpha = 0
            
        }
        else {
            leftDice.image = diceList[left]
            rightDice.image = diceList[right]
        }
    }

}

