//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol StockManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateStock(_ stockManager: StockManager, stock: StockModel)
}

struct StockManager {
    
    let stock = "BA"
    let baseURL = "https://api.tdameritrade.com/v1/marketdata/"
    let apiKey = "TDAMERITRADE_API_KEY"
    let urlAPIKey = "/quotes?apikey="
    var delegate: StockManagerDelegate?
    
    let stockArray = ["NDAQ", "AAPL", "GOOG", "TMUS", "SBUX", "NKE", "FB", "AMZN", "ROST", "COST", "PEP", "MAXR", "NFLX", "PYPL", "KO", "TSLA", "DIS", "SPY", "TM", "BA", "T", "JPM", "DKNG", "CAKE", "ULTA", "MCD", "TTD", "ROKU", "UAL", "LUV"]

    func getStockPrice (stock: String){
        let url = baseURL + stock + urlAPIKey + apiKey
        print(url)
        performRequest(urlString: url)
        
    }
    
    func performRequest(urlString: String){
        if let url = URL (string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let stock = self.parseJSON(safeData){
                        self.delegate?.didUpdateStock(self, stock: stock)
                    }

                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ stockData: Data) -> StockModel?{
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(DecodedStockData.self , from: stockData)
            let description = jsonData.array[0].description
            let symbol = jsonData.array[0].symbol
            let askPrice = jsonData.array[0].askPrice
            let lowPrice = jsonData.array[0].lowPrice
            let highPrice = jsonData.array[0].highPrice
            let divYield = jsonData.array[0].divYield
            
            return StockModel(symbol: symbol, description: description, askPrice: askPrice, lowPrice: lowPrice, highPrice: highPrice, divYield: divYield)
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
