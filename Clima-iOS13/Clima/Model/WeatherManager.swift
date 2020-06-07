//
//  WeatherManager.swift
//  Clima
//
//  Created by Vu Nguyen on 6/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var apiKey: String = "OPEN_WEATHER_API_KEY"
    var unit: String = "imperial"
    var location: String = ""
    var baseUrl: String = "https://api.openweathermap.org/data/2.5/weather"
    var delegate: WeatherManagerDelegate?
    
    func getWeather(location:String) {
        let stringLocation = location.replacingOccurrences(of: " ", with: "+")
        let weatherUrl = "\(baseUrl)?q=\(stringLocation),US&appid=\(apiKey)&units=\(unit)"
        performRequest(urlString: weatherUrl)
        
    }
    
    func getWeatherUsingCoordinate(long: Double, lat: Double){
        let weatherUrl = "\(baseUrl)?lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=\(unit)"
        performRequest(urlString: weatherUrl)
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
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }

                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = jsonData.weather[0].id
            let des = jsonData.weather[0].description
            let name = jsonData.name
            let temp = jsonData.main.temp
            
            return WeatherModel(id: id, name: name, temp: temp, des: des)
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
