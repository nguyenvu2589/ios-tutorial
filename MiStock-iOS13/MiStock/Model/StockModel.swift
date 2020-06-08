//
//  StockModel.swift
//  MiStock
//
//  Created by Vu Nguyen on 6/7/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct StockModel: Codable {
    let symbol: String
    let description: String
    let askPrice: Double
    let lowPrice: Double
    let highPrice: Double
    let divYield: Double
}
