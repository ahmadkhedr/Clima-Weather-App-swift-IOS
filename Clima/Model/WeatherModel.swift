//
//  WeatherModel.swift
//  Clima
//
//  Created by Ahmad Khedr on 17/12/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation



struct WeatherModel {
    
    let cityName : String
    let temrature : Double
    let conditionId : Int
    
    var temperatureString : String {
        return String(format: "%.1f", temrature)
    }
    var condition : String {
        switch(conditionId){
        case 200 ... 232 :
            return "cloud.bolt"
        case 300 ... 321 :
            return "cloud.drizzle"
            
        case 500 ... 531 :
            return "cloud.rain"
            
        case 600 ... 622 :
            return "cloud.snow"
            
        case 701 ... 781 :
            return "wind"
            
        case 800 :
            return "sun.min"
        case 801 ... 804 :
            return "cloud"
        default :
            return "cloud"
        }
        
    }
}


