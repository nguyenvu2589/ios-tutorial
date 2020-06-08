//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stockPicker: UIPickerView!
    @IBOutlet weak var displayLable: UILabel!
    @IBOutlet weak var desResult: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var askPrice: UILabel!
    @IBOutlet weak var lowPrice: UILabel!
    @IBOutlet weak var highPrice: UILabel!
    @IBOutlet weak var divYield: UILabel!
    
    
    var stockManager = StockManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockManager.delegate = self
        stockPicker.dataSource = self
        stockPicker.delegate = self
        stockManager.getStockPrice(stock: "NDAQ")
    }
    
    
    
}



// MARK: - StockManagerDelegate
extension ViewController: StockManagerDelegate{
    func didUpdateStock(_ stockManager: StockManager, stock: StockModel) {
        DispatchQueue.main.async {
            self.updateResult(stock: stock)
            
        }
    }
    
    func updateResult(stock: StockModel){
        self.displayLable.text = String(format: "%.2f", stock.askPrice)
        self.desResult.text = stock.description
        self.symbol.text = stock.symbol
        self.askPrice.text = String(stock.askPrice)
        self.lowPrice.text = String(stock.lowPrice)
        self.highPrice.text = String(stock.highPrice)
        self.divYield.text = String(stock.divYield)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 1 column
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        stockManager.stockArray.count
    }
    
    
}

// MARK: -
extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stockManager.stockArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedStock = stockManager.stockArray[row]
        stockManager.getStockPrice(stock: selectedStock)
    }
}
