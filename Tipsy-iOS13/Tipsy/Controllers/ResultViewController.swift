//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Vu Nguyen on 6/4/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var tipPercent: String?
    var numberOfSplit: String?
    var amountPerPerson: String?
    @IBOutlet weak var totalPerPerson: UILabel!
    @IBOutlet weak var SplitTipsInWords: UILabel!
    
    func updateTipsinWords() {
        let numPep = Int(self.numberOfSplit ?? "1")!
        
        if numPep > 1 {
            SplitTipsInWords.text = "Split between \(String(describing: numPep)), with \(self.tipPercent!)."
        }
        else {
            SplitTipsInWords.text = "You pay with \(self.tipPercent!)."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTipsinWords()
        totalPerPerson.text = "$\(amountPerPerson!)"
        
    }
    
    @IBAction func `return`(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
