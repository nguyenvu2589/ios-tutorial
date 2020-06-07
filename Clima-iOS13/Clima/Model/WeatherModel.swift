//
//  WeatherModel.swift
//  Clima
//
//  Created by Vu Nguyen on 6/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let id: Int
    let name: String
    let temp: Double
    let des: String
    
    var description: String{
        return des.trimmingCharacters(in: .whitespaces)
    }
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        switch id {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 701..<800:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801..<900:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
