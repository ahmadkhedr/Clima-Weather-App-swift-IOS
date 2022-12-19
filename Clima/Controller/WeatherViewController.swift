//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController   {
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ask for location permission from the user
        
        locationManager.requestWhenInUseAuthorization()
        
        
        locationManager.delegate = self
        searchTextField.delegate = self
        //get the current location once
        locationManager.requestLocation()
        weatherManager.delegate = self
        
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print(lat)
            print(long)
            weatherManager.fetchWeather(lat: String(lat)   , long: String(long))
            manager.stopUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
     print(error)
    }
    
    
    @IBAction func getCurrentLocationPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        print("Clicked")
    }
}



//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        
        // print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }else {
            searchTextField.placeholder = "Write SomeThing"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text {
            weatherManager.fetchWeather(cityName: cityName)
        }
        
        searchTextField.text = ""
    }
    
}

//MARK: - WatherManagerDelegate

extension WeatherViewController : WatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName:  weather.condition)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
        //
        //         //weatherModel.condition
        //
        //
        print(weather.temperatureString)
    }
    
    func didFailWithError(error: Error) {
        print("Errrror \(error)")
    }
}



