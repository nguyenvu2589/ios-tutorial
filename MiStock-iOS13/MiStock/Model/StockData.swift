//
//  StockData.swift
//  MiStock
//
//  Created by Vu Nguyen on 6/7/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct StockData: Codable {
    let symbol: String
    let description: String
    let askPrice: Double
    let lowPrice: Double
    let highPrice: Double
    let divYield: Double
}

struct DecodedStockData: Decodable {

    var array: [StockData]
    
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [StockData]()

        // 2
        // Loop through each key (student ID) in container
        for key in container.allKeys {

            // Decode Student using key & keep decoded Student object in tempArray
            let decodedObject = try container.decode(StockData.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        // 3
        // Finish decoding all Student objects. Thus assign tempArray to array.
        array = tempArray
    }
}
