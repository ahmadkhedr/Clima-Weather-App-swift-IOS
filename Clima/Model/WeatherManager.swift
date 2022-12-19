//
//  WeatherManager.swift
//  Clima
//
//  Created by Ahmad Khedr on 17/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
protocol WatherManagerDelegate {
    func didUpdateWeather(weather : WeatherModel)
    func didFailWithError(error : Error)
}
class WeatherManager {
    var delegate : WatherManagerDelegate?
    
    var baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=15791b55d0f0a0c4b822e04e196381fc&units=metric"
    
    func fetchWeather(cityName : String){
        let url = "\(baseUrl)&q=\(cityName)"
        performRequest(url: url)
        
    }
    
    func fetchWeather(lat : String , long :String){
        let url = "\(baseUrl)&lat=\(lat)&lon=\(long)"
        performRequest(url: url)
    }
    
    func performRequest(url : String){
        // Create a URL
        if  let appUrl = URL(string: url) {
            
            //Create a URL Session
            
            let session  = URLSession(configuration: .default)
            
            //Give URL session a tack
            
            let urlSession =  session.dataTask(with: appUrl) { data, response , error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let parsedWeatherModel = self.parseJson(waetherData: safeData){
                        
                        self.delegate?.didUpdateWeather(weather: parsedWeatherModel)
                        
                    }
                }
                
            }
            //start the task
            urlSession.resume()
            
            
        }
        
    }
    
    func parseJson(waetherData : Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let finalData =      try decoder.decode(WeatherDataModel.self, from: waetherData)
            
            let constionId = finalData.weather[0].id
            let cityAame = finalData.name
            let currentTemp = finalData.main.temp
            
            
            let model = WeatherModel(cityName: cityAame, temrature: currentTemp, conditionId: constionId)
            return model
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
        
    }
    
    
    
    //        func handerl(data : Data? , response : URLResponse? , error : Error?){
    //            if error != nil {
    //                print("error")
    //                return
    //            }
    //            if let dafeData = data {
    //                let stringData = String(data: dafeData, encoding: .utf8)
    //                print(stringData)
    //            }
    //        }
}
