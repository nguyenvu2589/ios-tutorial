//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherDes: UILabel!
    
    var long: Double = 0.0
    var lat: Double = 0.0
        
    var weatherMananger  = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        
        // require for return key in textfield
        searchTextField.delegate = self
        // for delegate
        weatherMananger.delegate = self
    }
    
    @IBAction func searchCurrentLocation(_ sender: UIButton) {
        weatherMananger.getWeatherUsingCoordinate(long: long, lat: lat)
    }
    
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton) {
           // hide soft keyboard
           searchTextField.endEditing(true)
       }
       
       // what todo when user hit return key
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // hide soft keyboard
           searchTextField.endEditing(true)
           return true
       }
       
       // kinda check value
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != "" {
               return true
           } else {
               textField.placeholder = "Type something?"
               return false
           }
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           // convert to from String? to String
           if let location = searchTextField.text{
               weatherMananger.getWeather(location: location)
           }
           
           searchTextField.text = ""
       }
}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    func didFailWithError(error: Error) {
          print(error)
          
      }
      func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
          DispatchQueue.main.async {
              self.conditionImageView.image = UIImage(systemName: weather.conditionName)
              self.temperatureLabel.text = weather.tempString
              self.cityLabel.text = weather.name
              self.weatherDes.text = weather.description
          }

      }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            self.lat = location.coordinate.latitude
            self.long = location.coordinate.longitude
            weatherMananger.getWeatherUsingCoordinate(long: long, lat: lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
